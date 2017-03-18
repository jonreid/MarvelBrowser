//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharacterResponseBuilder.h"

#import "QCOCharacterResponse.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOCharacterResponseBuilderTests : XCTestCase
@end

@implementation QCOCharacterResponseBuilderTests
{
    QCOCharacterResponseBuilder *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[QCOCharacterResponseBuilder alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testParseDictionary_WithNonStringName_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"name": @123 };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.name, is(nilValue()));
}

- (void)testParseDictionary_WithName_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"name": @"NAME" };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.name, is(@"NAME"));
}

- (void)testBuild_ShouldHaveGivenName
{
    NSDictionary *dict = @{ @"name": @"NAME" };
    [sut parseDictionary:dict];
    
    QCOCharacterResponse *response = [sut build];
    
    assertThat(response.name, is(@"NAME"));
}

@end
