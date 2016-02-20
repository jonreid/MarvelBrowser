//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOURLQueryMatcher.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOURLQueryMatcherTests : XCTestCase
@end

@implementation QCOURLQueryMatcherTests

- (void)testShouldMatchURLContainingMatchingKeyAndValueInFirstPosition
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=value1"];

    assertThat(url, hasQuery(@"key1", equalTo(@"value1")));
}

- (void)testShouldMatchURLContainingMatchingKeyAndValueInSecondPosition
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=value1&key2=value2"];

    assertThat(url, hasQuery(@"key2", equalTo(@"value2")));
}

- (void)testShouldNotMatchURLNotContainingMatchingKey
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?WRONGKEY=value1"];

    assertThat(url, isNot(hasQuery(@"key1", equalTo(@"value1"))));
}

- (void)testShouldNotMatchURLContainingMatchingKeyButWrongValue
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=WRONGVALUE"];

    assertThat(url, isNot(hasQuery(@"key1", equalTo(@"value1"))));
}

- (void)testShouldProvideConvenientShortcutForMatchingValueWithEqualTo
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=value1"];

    assertThat(url, hasQuery(@"key1", @"value1"));
}

- (void)testMatcherShouldHaveReadableDescription
{
    id <HCMatcher> matcher = hasQuery(@"key1", @"value1");
    HCStringDescription *description = [HCStringDescription stringDescription];

    [description appendDescriptionOf:matcher];

    assertThat(description.description, is(@"a URL with \"key1\" = \"value1\""));
}

@end
