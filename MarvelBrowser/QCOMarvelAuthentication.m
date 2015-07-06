//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

@implementation QCOMarvelAuthentication

+ (NSString *)timestamp
{
    return @([NSDate date].timeIntervalSinceReferenceDate).stringValue;
}

@end
