//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOFetchCharactersResponseModel.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOFetchCharactersResponseBuilderTests : XCTestCase
@end

@implementation QCOFetchCharactersResponseBuilderTests
{
    QCOFetchCharactersResponseBuilder *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[QCOFetchCharactersResponseBuilder alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testParseDictionary_WithNonIntegerCode_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"code": @"409" };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.code, is(nilValue()));
}

- (void)testParseDictionary_WithCode_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"code": @200 };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.code, is(@200));
}

- (void)testParseDictionary_WithNonStringStatus_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"status": @409 };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.status, is(nilValue()));
}

- (void)testParseDictionary_WithStatus_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"status": @"STATUS" };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.status, is(@"STATUS"));
}

- (void)testParseDictionary_WithNonDictionaryData_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"data": @123 };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.data, is(nilValue()));
}

- (void)testParseDictionary_WithData_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"data": @{ @"offset": @123 } };
    
    [sut parseDictionary:dict];
    
    assertThat(sut.data, hasProperty(@"offset", @123));
}

- (void)testBuild_RequiresCode
{
    NSDictionary *dict = @{ @"status": @"STATUS" };
    
    [sut parseDictionary:dict];
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(response, is(nilValue()));
}

@end
