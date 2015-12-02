//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOMarvelAuthenticationTests : XCTestCase
@end

@implementation QCOMarvelAuthenticationTests
{
    QCOMarvelAuthentication *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[QCOMarvelAuthentication alloc] init];
}

- (void)testTimestamp_ShouldNotChangeOnTheSameInstance
{
    NSString *ts1 = sut.timestamp;
    NSString *ts2 = sut.timestamp;

    assertThat(ts1, is(equalTo(ts2)));
}

- (void)testTimestamp_ShouldChangeAcrossDifferentInstances
{
    NSString *ts1 = sut.timestamp;
    NSString *ts2 = [[QCOMarvelAuthentication alloc] init].timestamp;

    assertThat(ts1, isNot(equalTo(ts2)));
}

- (void)testPublicKey_ShouldHave32Characters
{
    NSString *key = sut.publicKey;

    assertThat(@(key.length), is(@32));
}

- (void)testPrivateKey_ShouldHave40Characters
{
    NSString *key = sut.privateKey;

    assertThat(@(key.length), is(@40));
}

- (void)testMD5OfKnownString_ShouldYieldKnownResult  // http://tools.ietf.org/html/rfc1321
{
    NSString *md5 = sut.calculateMD5(@"abc");

    assertThat(md5, is(@"900150983cd24fb0d6963f7d28e17f72"));
}

- (void)testURLParameters_ShouldHaveTimestampPublicKeyAndHashedConcatenation
{
    sut.timestamp = @"Timestamp";
    sut.privateKey = @"Private";
    sut.publicKey = @"Public";
    sut.calculateMD5 = ^(NSString *str){ return [NSString stringWithFormat:@"MD5%@MD5", str]; };

    NSString *params = [sut URLParameters];

    assertThat(params, is(@"&ts=Timestamp&apikey=Public&hash=MD5TimestampPrivatePublicMD5"));
}

@end
