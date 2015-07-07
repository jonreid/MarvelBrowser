//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface QCOMarvelAuthenticationTests : XCTestCase
@end

@implementation QCOMarvelAuthenticationTests

- (void)testTimestamp_ShouldNotChangeOnTheSameInstance
{
    QCOMarvelAuthentication *sut = [[QCOMarvelAuthentication alloc] init];

    NSString *ts1 = sut.timestamp;
    NSString *ts2 = sut.timestamp;

    assertThat(ts1, equalTo(ts2));
}

- (void)testTimestamp_ShouldChangeAcrossDifferentInstances
{
    QCOMarvelAuthentication *sut = [[QCOMarvelAuthentication alloc] init];

    NSString *ts1 = sut.timestamp;
    NSString *ts2 = [[QCOMarvelAuthentication alloc] init].timestamp;

    assertThat(ts1, isNot(equalTo(ts2)));
}

- (void)testPublicKey_ShouldHave32Characters
{
    QCOMarvelAuthentication *sut = [[QCOMarvelAuthentication alloc] init];

    NSString *key = sut.publicKey;

    assertThat(@(key.length), is(@32));
}

- (void)testPrivateKey_ShouldHave40Characters
{
    QCOMarvelAuthentication *sut = [[QCOMarvelAuthentication alloc] init];

    NSString *key = sut.privateKey;

    assertThat(@(key.length), is(@40));
}

@end
