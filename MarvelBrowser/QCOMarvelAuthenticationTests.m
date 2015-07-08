//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface TestingMarvelAuthentication : QCOMarvelAuthentication
@end

@implementation TestingMarvelAuthentication

- (NSString *)MD5OfString:(NSString *)str
{
    return [NSString stringWithFormat:@"MD5%@MD5", str];
}

@end


@interface QCOMarvelAuthentication (Testing)
@property (nonatomic, copy, readwrite) NSString *timestamp;
@property (nonatomic, copy, readwrite) NSString *publicKey;
@property (nonatomic, copy, readwrite) NSString *privateKey;
@end


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

    assertThat(ts1, equalTo(ts2));
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

- (void)testTimestampedKeys_ShouldConcatenateTimestampPrivateKeyPublicKey
{
    sut.timestamp = @"Timestamp";
    sut.privateKey = @"Private";
    sut.publicKey = @"Public";

    assertThat([sut timestampedKeys], is(@"TimestampPrivatePublic"));
}

- (void)testMD5OfKnownString_ShouldYieldKnownResult  // http://tools.ietf.org/html/rfc1321
{
    NSString *md5 = [sut MD5OfString:@"abc"];

    assertThat(md5, is(@"900150983cd24fb0d6963f7d28e17f72"));
}

- (void)testURLParameters_ShouldHaveTimestampPublicKeyAndHash
{
    TestingMarvelAuthentication *sutWithFakeMD5 = [[TestingMarvelAuthentication alloc] init];
    sutWithFakeMD5.timestamp = @"Timestamp";
    sutWithFakeMD5.privateKey = @"Private";
    sutWithFakeMD5.publicKey = @"Public";

    NSString *params = [sutWithFakeMD5 URLParameters];

    assertThat(params, is(@"&ts=Timestamp&apikey=Public&hash=MD5TimestampPrivatePublicMD5"));
}

@end
