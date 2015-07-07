//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import "MarvelKeys.m"

@interface QCOMarvelAuthentication ()
@property (nonatomic, copy, readwrite) NSString *timestamp;
@end

@implementation QCOMarvelAuthentication

+ (NSString *)publicKey
{
    return MarvelPublicKey;
}

+ (NSString *)privateKey
{
    return MarvelPrivateKey;
}

- (NSString *)timestamp
{
    if (!_timestamp)
        _timestamp = @([NSDate date].timeIntervalSinceReferenceDate).stringValue;
    return _timestamp;
}

@end
