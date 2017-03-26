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

- (NSDictionary *)requiredDataFieldsWithDictionary:(NSDictionary *)dict
{
    NSMutableDictionary *dictPlusData = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [dictPlusData addEntriesFromDictionary:@{
            @"data": @{
                    @"offset": @0,
                    @"total": @0,
            }
    }];
    return dictPlusData;
}

- (void)testBuild_WithRequiredCode_ShouldHaveGivenField
{
    NSDictionary *dict = [self requiredDataFieldsWithDictionary:@{
            @"code": @123,
    }];
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@123));
}

- (void)testBuild_WithStatus_ShouldHaveGivenField
{
    NSDictionary *dict = [self requiredDataFieldsWithDictionary:@{
            @"code": @200,
            @"status": @"STATUS",
    }];
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(response.status, is(@"STATUS"));
}

- (void)testBuild_WithoutCode_ShouldReturnCode500
{
    NSDictionary *dict = [self requiredDataFieldsWithDictionary:@{
            @"status": @"STATUS",
    }];
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@500));
}

- (void)testBuild_WithCodePlusDataWithRequiredFields_ShouldHaveSlice
{
    NSDictionary *dict = @{
            @"code": @200,
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

- (void)testBuild_WithSuccess200CodeButNoData_ShouldReturnCode500
{
    NSDictionary *dict = @{
            @"code": @200,
    };
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@500));
}

- (void)testBuild_WithErrorCodeAndNoData_ShouldReturnGivenCode
{
    NSDictionary *dict = @{
            @"code": @409,
    };
    QCOFetchCharactersResponseBuilder *sut = [[QCOFetchCharactersResponseBuilder alloc] initWithDictionary:dict];
    
    QCOFetchCharactersResponseModel *response = [sut build];
    
    assertThat(@(response.code), is(@409));
}

@end
