//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOFetchCharactersResponseModel.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOFetchCharactersResponseBuilderTests : XCTestCase
@end

@implementation QCOFetchCharactersResponseBuilderTests

- (void)testInit_WithNonIntegerCode_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"code": @"409" };
    
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.code, is(nilValue()));
}

- (void)testInit_WithCode_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"code": @200 };
    
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.code, is(@200));
}

- (void)testInit_WithNonStringStatus_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"status": @409 };
    
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.status, is(nilValue()));
}

- (void)testInit_WithStatus_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"status": @"STATUS" };
    
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.status, is(@"STATUS"));
}

- (void)testInit_WithNonDictionaryData_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"data": @123 };
    
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.data, is(nilValue()));
}

- (void)testInit_WithData_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"data": @{ @"offset": @123 } };
    
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.data, hasProperty(@"offset", @123));
}

- (void)testBuild_WithRequiredCode_ShouldHaveGivenField
{
    NSDictionary *dict = @{
            @"code": @123,
            @"data": @{
                    @"offset": @1,
                    @"total": @2,
            }
    };
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@123));
}

- (void)testBuild_WithStatus_ShouldHaveGivenField
{
    NSDictionary *dict = @{
            @"code": @123,
            @"status": @"STATUS",
            @"data": @{
                    @"offset": @1,
                    @"total": @2,
            }
    };
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@123));
    assertThat(response.status, is(@"STATUS"));
}

- (void)testBuild_WithoutCode_ShouldReturnCode500
{
    NSDictionary *dict = @{
            @"status": @"STATUS",
            @"data": @{
                    @"offset": @1,
                    @"total": @2,
            }
    };
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@500));
}

- (void)testBuild_WithCodePlusDataWithRequiredFields_ShouldHaveSlice
{
    NSDictionary *dict = @{
            @"code": @123,
            @"data": @{
                    @"offset": @1,
                    @"total": @2,
            }
    };
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(response.slice, hasProperty(@"offset", @1));
    assertThat(response.slice, hasProperty(@"total", @2));
}

@end
