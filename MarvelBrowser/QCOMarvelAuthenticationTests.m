//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface QCOMarvelAuthenticationTests : XCTestCase
@end

@implementation QCOMarvelAuthenticationTests

- (void)testTimestamp_ShouldChangeEveryCall
{
    NSString *ts1 = [QCOMarvelAuthentication timestamp];
    NSString *ts2 = [QCOMarvelAuthentication timestamp];

    assertThat(ts1, isNot(equalTo(ts2)));
}

@end
