//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

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

- (void)testParseJSONData_WithCode200
{
    NSString *json = @"{\"code\":200}";
    
    QCOFetchCharactersResponseModel* response = [sut parseJSONData:jsonData(json)];
    
    assertThat(@(response.code), is(@200));
}

- (void)testParseJSONData_WithCode409
{
    NSString *json = @"{\"code\":409}";
    
    QCOFetchCharactersResponseModel* response = [sut parseJSONData:jsonData(json)];
    
    assertThat(@(response.code), is(@409));
}

- (void)testParseJSONData_WithMalformedJSON_ShouldYieldNil
{
    NSString *json = @"{\"cod";
    
    QCOFetchCharactersResponseModel* response = [sut parseJSONData:jsonData(json)];
    
    assertThat(response, is(nilValue()));
}

- (void)testParseJSONData_WithJSONArrayInsteadOfDictionary_ShouldYieldNil
{
    NSString *json = @"[]";
    
    QCOFetchCharactersResponseModel* response = [sut parseJSONData:jsonData(json)];
    
    assertThat(response, is(nilValue()));
}

@end
