//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

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

- (void)testParseJSONData_WithCode200
{
    NSData *jsonData = [@"{\"code\":200}"
            dataUsingEncoding:NSUTF8StringEncoding];
    
    QCOFetchCharactersResponseModel* response = [sut parseJSONData:jsonData];
    
    assertThat(@(response.code), is(@200));
}

- (void)testParseJSONData_WithCode409
{
    NSData *jsonData = [@"{\"code\":409}"
            dataUsingEncoding:NSUTF8StringEncoding];
    
    QCOFetchCharactersResponseModel* response = [sut parseJSONData:jsonData];
    
    assertThat(@(response.code), is(@409));
}

@end
