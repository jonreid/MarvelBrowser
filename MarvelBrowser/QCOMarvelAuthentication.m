//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import "MarvelKeys.m"


@implementation QCOMarvelAuthentication

+ (NSString *)timestamp
{
    return @([NSDate date].timeIntervalSinceReferenceDate).stringValue;
}

+ (NSString *)publicKey
{
    return MarvelPublicKey;
}

+ (NSString *)privateKey
{
    return MarvelPrivateKey;
}

@end
