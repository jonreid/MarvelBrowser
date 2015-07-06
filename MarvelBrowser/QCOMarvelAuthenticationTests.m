//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <XCTest/XCTest.h>
#import "QCOMarvelAuthentication.h"


@interface QCOMarvelAuthenticationTests : XCTestCase
@end

@implementation QCOMarvelAuthenticationTests

- (void)testTimestamp_ShouldChangeEveryCall
{
    NSString *ts1 = [QCOMarvelAuthentication timestamp];
    NSString *ts2 = [QCOMarvelAuthentication timestamp];

    XCTAssertNotEqualObjects(ts1, ts2);
}

@end
