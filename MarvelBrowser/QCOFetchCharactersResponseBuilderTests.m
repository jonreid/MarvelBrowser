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

- (void)testParseJSONData_WithNonIntegerCode_ShouldCaptureNilInBuilder
{
    NSString *json = @"{\"code\":\"409\"}";
    
    [sut parseJSONData:jsonData(json)];
    
    assertThat(sut.code, is(nilValue()));
}

- (void)testParseJSONData_WithCode_ShouldCaptureValueInBuilder
{
    NSString *json = @"{\"code\":200}";
    
    [sut parseJSONData:jsonData(json)];
    
    assertThat(sut.code, is(@200));
}

- (void)testParseJSONData_WithNonStringStatus_ShouldCaptureNilInBuilder
{
    NSString *json = @"{\"status\":409}";
    
    [sut parseJSONData:jsonData(json)];
    
    assertThat(sut.status, is(nilValue()));
}

- (void)testParseJSONData_WithStatus_ShouldCaptureValueInBuilder
{
    NSString *json = @"{\"status\":\"STATUS\"}";
    
    [sut parseJSONData:jsonData(json)];
    
    assertThat(sut.status, is(@"STATUS"));
}

- (void)testParseJSONData_WithNonDictionaryData_ShouldCaptureNilInBuilder
{
    NSString *json = @"{\"data\":123}";
    
    [sut parseJSONData:jsonData(json)];
    
    assertThat(sut.data, is(nilValue()));
}

- (void)testParseJSONData_WithData_ShouldCaptureValueInBuilder
{
    NSString *json = @"{\"data\":{\"offset\":123}}";
    
    [sut parseJSONData:jsonData(json)];
    
    assertThat(sut.data, hasProperty(@"offset", @123));
}

- (void)testBuild_FromMalformedJSON_ShouldReturnNil
{
    NSString *json = @"{\"cod";
    
    [sut parseJSONData:jsonData(json)];
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(response, is(nilValue()));
}

- (void)testBuild_FromJSONArrayInsteadOfDictionary_ShouldReturnNil
{
    NSString *json = @"[]";
    
    [sut parseJSONData:jsonData(json)];
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(response, is(nilValue()));
}

- (NSString *)sampleResponse
{
    return @"{"
            "  \"code\": 200,"
            "  \"status\": \"Ok\","
            "  \"data\": {"
            "    \"offset\": 0,"
            "    \"limit\": 20,"
            "    \"total\": 4,"
            "    \"count\": 4,"
            "    \"results\": ["
            "      {"
            "        \"name\": \"Deadpool\""
            "      }"
            "    ]"
            "  }"
            "}";
}

- (void)testBuild_FromSampleResponse_ShouldYieldCode200
{
    NSString *json = [self sampleResponse];
    
    [sut parseJSONData:jsonData(json)];
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@200));
}

- (void)testBuild_FromSampleResponse_ShouldYieldStatusOk
{
    NSString *json = [self sampleResponse];
    
    [sut parseJSONData:jsonData(json)];
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(response.status, is(@"Ok"));
}

@end
