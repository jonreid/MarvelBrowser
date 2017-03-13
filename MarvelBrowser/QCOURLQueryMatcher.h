//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <OCHamcrest/HCDiagnosingMatcher.h>


@interface QCOURLQueryMatcher : HCDiagnosingMatcher

- (instancetype)initWithName:(NSString *)name valueMatcher:(id <HCMatcher>)valueMatcher;

@end


FOUNDATION_EXPORT id hasQuery(NSString *name, id valueMatcher);
