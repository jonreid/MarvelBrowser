//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import "MarvelKeys.m"

@interface QCOMarvelAuthentication ()
@property (nonatomic, copy, readwrite) NSString *timestamp;
@property (nonatomic, copy, readwrite) NSString *publicKey;
@property (nonatomic, copy, readwrite) NSString *privateKey;
@end

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

- (NSString *)timestampedKeys
{
    return [NSString stringWithFormat:@"%@%@%@", self.timestamp, self.privateKey, self.publicKey];
}

@end
