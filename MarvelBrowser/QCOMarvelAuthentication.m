//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import "MarvelKeys.m"
#import <CommonCrypto/CommonDigest.h>


@implementation QCOMarvelAuthentication

+ (NSString *)URLParameters
{
    return [[[self alloc] init] URLParameters];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _publicKey = [MarvelPublicKey copy];
        _privateKey = [MarvelPrivateKey copy];
    }
    return self;
}

- (NSString *(^)(NSString *))calculateMD5
{
    if (!_calculateMD5)
    {
        _calculateMD5 = ^(NSString *str){
            const char *cstr = [str UTF8String];
            unsigned char digest[CC_MD5_DIGEST_LENGTH];
            CC_MD5(cstr, (CC_LONG)strlen(cstr), digest);
            return [NSString stringWithFormat:
                    @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    digest[0], digest[1], digest[2], digest[3],
                    digest[4], digest[5], digest[6], digest[7],
                    digest[8], digest[9], digest[10], digest[11],
                    digest[12], digest[13], digest[14], digest[15]];
        };
    }
    return _calculateMD5;
}

- (NSString *)URLParameters
{
    return [self URLParametersWithTimestamp:[self timestamp]];
}

- (NSString *)timestamp
{
    return @([NSDate date].timeIntervalSinceReferenceDate).stringValue;
}

- (NSString *)URLParametersWithTimestamp:(NSString *)timestamp
{
    NSString *hash = self.calculateMD5([NSString stringWithFormat:@"%@%@%@", timestamp, self.privateKey, self.publicKey]);
    return [NSString stringWithFormat:@"&ts=%@&apikey=%@&hash=%@", timestamp, self.publicKey, hash];
}

@end
