//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharacterResponseBuilder.h"

#import "QCOCharacterResponseModel.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOCharacterResponseBuilderTests : XCTestCase
@end

@implementation QCOCharacterResponseBuilderTests

- (void)testInit_WithNonStringName_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"name": @123 };
    
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.name, is(nilValue()));
}

- (void)testInit_WithName_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"name": @"NAME" };
    
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.name, is(@"NAME"));
}

- (void)testBuild_WithName_ShouldHaveGivenName
{
    NSDictionary *dict = @{ @"name": @"NAME" };
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterResponseModel *response = [sut build];
    
    assertThat(response.name, is(@"NAME"));
}

- (void)testBuild_WithoutName_ShouldReturnNil
{
    NSDictionary *dict = @{};
    QCOCharacterResponseBuilder *sut = [[QCOCharacterResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterResponseModel *response = [sut build];
    
    assertThat(response, is(nilValue()));
}

@end
