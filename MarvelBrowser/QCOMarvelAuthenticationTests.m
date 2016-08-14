//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

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

- (void)testURLParametersWithTimestamp_ShouldHaveTimestampPublicKeyAndHashedConcatenation
{
    sut.privateKey = @"Private";
    sut.publicKey = @"Public";
    sut.calculateMD5 = ^(NSString *str){ return [NSString stringWithFormat:@"MD5%@MD5", str]; };

    NSString *params = [sut URLParametersWithTimestamp:@"Timestamp"];

    assertThat(params, is(@"&ts=Timestamp&apikey=Public&hash=MD5TimestampPrivatePublicMD5"));
}

- (void)testURLParameters_ShouldChangeAcrossDifferentInvocations
{
    NSString *params1 = [sut URLParameters];
    NSString *params2 = [sut URLParameters];
    
    assertThat(params1, isNot(equalTo(params2)));
}

@end
