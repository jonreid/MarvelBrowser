//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharactersSliceResponseBuilder.h"

#import "QCOCharacterSliceResponseModel.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOCharactersSliceResponseBuilderTests : XCTestCase
@end

@implementation QCOCharactersSliceResponseBuilderTests

- (void)testInit_WithNonIntegerOffset_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"offset": @"123" };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.offset, is(nilValue()));
}

- (void)testInit_WithIntegerOffset_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"offset": @123 };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.offset, is(@123));
}

- (void)testInit_WithNonIntegerTotal_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"total": @"123" };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.total, is(nilValue()));
}

- (void)testInit_WithIntegerTotal_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"total": @123 };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.total, is(@123));
}

- (void)testInit_WithNonArrayResult_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"results":
            @{ @"name": @"DUMMY" }
    };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, is(nilValue()));
}

- (void)testInit_WithTwoResults_ShouldCaptureTwoCharactersInBuilder
{
    NSDictionary *dict = @{ @"results": @[
            @{ @"name": @"ONE" },
            @{ @"name": @"TWO" },
    ] };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, containsIn(@[
            hasProperty(@"name", @"ONE"),
            hasProperty(@"name", @"TWO"),
    ]));
}

- (void)testInit_WithTwoResultsButFirstNotDictionary_ShouldCaptureValidSecondResult
{
    NSDictionary *dict = @{ @"results": @[
            @"DUMMY",
            @{ @"name": @"TWO" },
    ] };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, containsIn(@[
            hasProperty(@"name", @"TWO"),
    ]));
}

- (void)testBuild_WithAllRequiredFields_ShouldHaveGivenFields
{
    NSDictionary *dict = @{
            @"offset": @123,
            @"total": @456,
    };
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
 
    assertThat(@(response.offset), is(@123));
    assertThat(@(response.total), is(@456));
}

- (void)testBuild_MissingOffset_ShouldReturnNil
{
    NSDictionary *dict = @{
            @"total": @456,
    };
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
    
    assertThat(response, is(nilValue()));
}

- (void)testBuild_MissingTotal_ShouldReturnNil
{
    NSDictionary *dict = @{
            @"offset": @123,
    };
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
    
    assertThat(response, is(nilValue()));
}

- (NSDictionary *)requiredFieldsWithDictionary:(NSDictionary *)dict
{
    NSMutableDictionary *dictPlusData = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [dictPlusData addEntriesFromDictionary:@{
            @"offset": @0,
            @"total": @0,
    }];
    return dictPlusData;
}

- (void)testBuild_WithRequiredFieldsPlusTwoResults_ShouldHaveTwoCharacters
{
    NSDictionary *dict = [self requiredFieldsWithDictionary:@{
            @"results": @[
                    @{ @"name": @"ONE" },
                    @{ @"name": @"TWO" },
            ],
    }];
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
    
    assertThat(response.characters, containsIn(@[
            hasProperty(@"name", @"ONE"),
            hasProperty(@"name", @"TWO"),
    ]));
}

- (void)testBuild_WithRequiredFieldsPlusTwoResultsButFirstCharacterMissingName_ShouldHaveOneCharacter
{
    NSDictionary *dict = [self requiredFieldsWithDictionary:@{
            @"results": @[
                    @{},
                    @{ @"name": @"TWO" },
            ],
    }];
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
    
    assertThat(response.characters, containsIn(@[
            hasProperty(@"name", @"TWO"),
    ]));
}

- (void)testBuild_WithRequiredFieldsButNoResults_ShouldHaveEmptyCharactersArray
{
    NSDictionary *dict = [self requiredFieldsWithDictionary:@{}];
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
    
    assertThat(response.characters, isEmpty());
}

@end
