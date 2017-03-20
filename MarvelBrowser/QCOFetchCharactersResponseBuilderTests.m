//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOFetchCharactersResponseModel.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


static NSData *jsonData(NSString *json)
{
    return [json dataUsingEncoding:NSUTF8StringEncoding];
}


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

- (QCOFetchCharactersResponseModel *)buildSampleResponse
{
    NSString *sampleResponse =
            @"{"
            "  \"code\": 200,"
            "  \"status\": \"Ok\","
            "  \"data\": {"
            "    \"offset\": 1,"
            "    \"total\": 3,"
            "    \"results\": ["
            "      {"
            "        \"name\": \"NAME1\""
            "      },"
            "      {"
            "        \"name\": \"NAME2\""
            "      }"
            "    ]"
            "  }"
            "}";
    [sut parseJSONData:jsonData(sampleResponse)];
    return [sut build];
}

- (void)testBuild_FromSampleResponse_ShouldHaveCode200
{
    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
    
    assertThat(@(response.code), is(@200));
}

- (void)testBuild_FromSampleResponse_ShouldHaveStatusOk
{
    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
    
    assertThat(response.status, is(@"Ok"));
}

- (void)testBuild_FromSampleResponse_ShouldHaveOffset1
{
    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
    
    assertThat(@(response.offset), is(@1));
}

- (void)testBuild_FromSampleResponse_ShouldHaveTotal3
{
    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
    
    assertThat(@(response.total), is(@3));
}

- (void)testBuild_FromSampleResponse_ShouldHaveTwoCharacters
{
    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
    
    assertThat(response.characters, containsIn(@[
            hasProperty(@"name", @"NAME1"),
            hasProperty(@"name", @"NAME2")]));
}

@end
