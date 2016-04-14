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

    assertThat(description.description, is(@"URL with \"key1\" = \"value1\""));
}

- (void)testShouldNotMatchNonURL
{
    assertThat([[NSObject alloc] init], isNot(hasQuery(@"DUMMY", @"DUMMY")));
}

- (void)testShouldNotMatchNil
{
    assertThat(nil, isNot(hasQuery(@"DUMMY", @"DUMMY")));
}

- (void)testCreatingMatcherWithNilName_ShouldThrowException
{
    assertThat(^{ hasQuery(nil, @"value1"); }, throwsException(anything()));
}

- (void)testCreatingMatcherWithNilValue_ShouldThrowException
{
    assertThat(^{ hasQuery(@"key1", nil); }, throwsException(anything()));
}

- (void)testMismatchDescriptionOfNonURL
{
    id <HCMatcher> matcher = hasQuery(@"key1", @"value1");
    HCStringDescription *description = [HCStringDescription stringDescription];

    [matcher describeMismatchOf:@"ABC" to:description];

    assertThat(description.description, is(@"was \"ABC\""));
}

- (void)testMismatchDescriptionOfURLNotContainingMatchingKey
{
    id <HCMatcher> matcher = hasQuery(@"key1", @"value1");
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?WRONGKEY=value1"];
    HCStringDescription *description = [HCStringDescription stringDescription];

    [matcher describeMismatchOf:url to:description];

    assertThat(description.description, is(@"no \"key1\" name in WRONGKEY=value1"));
}

- (void)testMismatchDescriptionWhenThereIsNoQuery
{
    id <HCMatcher> matcher = hasQuery(@"key1", @"value1");
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy"];
    HCStringDescription *description = [HCStringDescription stringDescription];

    [matcher describeMismatchOf:url to:description];

    assertThat(description.description, is(@"no query in <http://dummy.com/dummy>"));
}

- (void)testMismatchDescriptionOfURLContainingMatchingKeyWithWrongValue
{
    id <HCMatcher> matcher = hasQuery(@"key1", @"value1");
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=WRONGVALUE"];
    HCStringDescription *description = [HCStringDescription stringDescription];

    [matcher describeMismatchOf:url to:description];

    assertThat(description.description, is(@"\"key1\" had value \"WRONGVALUE\" in key1=WRONGVALUE"));
}

- (void)testShouldMatchURLContainingMatchingKeyAndPercentEncodedValue
{
    NSURL *url = [NSURL URLWithString:@"http://dummy.com/dummy?key1=ab%20cd"];

    assertThat(url, hasQuery(@"key1", equalTo(@"ab%20cd")));
}


@end
