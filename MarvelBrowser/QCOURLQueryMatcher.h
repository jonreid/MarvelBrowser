//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import <OCHamcrest/HCBaseMatcher.h>


@interface QCOURLQueryMatcher : HCBaseMatcher

- (instancetype)initWithName:(NSString *)name valueMatcher:(id)valueMatcher;

@end


FOUNDATION_EXPORT id hasQuery(NSString *name, id valueMatcher);
