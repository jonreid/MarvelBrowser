//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import "MarvelKeys.m"
#import <CommonCrypto/CommonDigest.h>


@implementation QCOMarvelAuthentication

- (NSString *)timestamp
{
    if (!_timestamp)
        _timestamp = @([NSDate date].timeIntervalSinceReferenceDate).stringValue;
    return _timestamp;
}

- (NSString *)publicKey
{
    if (!_publicKey)
        _publicKey = MarvelPublicKey;
    return _publicKey;
}

- (NSString *)privateKey
{
    if (!_privateKey)
        _privateKey = MarvelPrivateKey;
    return _privateKey;
}

- (NSString *)URLParameters
{
    return [NSString stringWithFormat:@"&ts=%@&apikey=%@&hash=%@",
                    self.timestamp, self.publicKey, [self MD5OfString:[self timestampedKeys]]
    ];
}

- (NSString *)timestampedKeys
{
    return [NSString stringWithFormat:@"%@%@%@", self.timestamp, self.privateKey, self.publicKey];
}

- (NSString *)MD5OfString:(NSString *)str
{
    const char *cstr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, strlen(cstr), digest);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            digest[0], digest[1], digest[2], digest[3],
            digest[4], digest[5], digest[6], digest[7],
            digest[8], digest[9], digest[10], digest[11],
            digest[12], digest[13], digest[14], digest[15]
    ];
}

@end
