//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOURLQueryMatcher.h"


@implementation QCOURLQueryMatcher

- (BOOL)matches:(id)item
{
    return YES;
}

- (void)describeTo:(id <HCDescription>)description
{
}

@end


id hasQuery(NSString *name, id valueMatcher)
{
    return [[QCOURLQueryMatcher alloc] init];
}
