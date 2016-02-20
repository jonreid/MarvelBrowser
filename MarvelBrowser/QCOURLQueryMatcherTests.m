//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOURLQueryMatcher.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOURLQueryMatcherTests : XCTestCase
@end

@implementation QCOURLQueryMatcherTests

- (void)testHasQuery_WithURLContainingMatchingKeyAndValueInFirstPosition_ShouldMatch
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=value1"];

    assertThat(url, hasQuery(@"key1", equalTo(@"value1")));
}

- (void)testHasQuery_WithURLContainingMatchingKeyAndValueInSecondPosition_ShouldMatch
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=value1&key2=value2"];

    assertThat(url, hasQuery(@"key2", equalTo(@"value2")));
}

- (void)testHasQuery_WithURLNotContainingMatchingKey_ShouldNotMatch
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?WRONGKEY=value1"];

    assertThat(url, isNot(hasQuery(@"key1", equalTo(@"value1"))));
}

- (void)testHasQuery_WithURLContainingMatchingKeyButWrongValue_ShouldNotMatch
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=WRONGVALUE"];

    assertThat(url, isNot(hasQuery(@"key1", equalTo(@"value1"))));
}

- (void)testHasQuery_ShouldProvideConvenientShortcutForMatchingValueWithEqualTo
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=value1"];

    assertThat(url, hasQuery(@"key1", @"value1"));
}

@end
