//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharacterResponseBuilder.h"

#import "QCOCharacterResponse.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOCharacterResponseBuilderTests : XCTestCase
@end

@implementation QCOCharacterResponseBuilderTests

- (void)testParseDictionary_WithNonStringName_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"name": @123 };
    
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.name, is(nilValue()));
}

- (void)testParseDictionary_WithName_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"name": @"NAME" };
    
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.name, is(@"NAME"));
}

- (void)testBuild_ShouldHaveGivenName
{
    NSDictionary *dict = @{ @"name": @"NAME" };
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterResponse *response = [sut build];
    
    assertThat(response.name, is(@"NAME"));
}

- (void)testBuild_RequiresName
{
    NSDictionary *dict = @{};
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterResponse *response = [sut build];
    
    assertThat(response, is(nilValue()));
}

@end
