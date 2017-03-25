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

- (void)testInit_WithOffset_ShouldCaptureValueInBuilder
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

- (void)testInit_WithTotal_ShouldCaptureValueInBuilder
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

- (void)testInit_WithOneResultThatIsNotDictionary_ShouldCaptureArraySizeZeroInBuilder
{
    NSDictionary *dict = @{ @"results": @[
            @[ @"DUMMY" ],
    ] };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, hasCountOf(0));
}

- (void)testInit_WithOneResult_ShouldCaptureOneCharacterInBuilder
{
    NSDictionary *dict = @{ @"results": @[
            @{ @"name": @"ONE" },
    ] };
    
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, containsIn(@[
            hasProperty(@"name", @"ONE"),
    ]));
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

- (void)XXXtestBuild_WithRequiredFieldsPlusTwoResults_ShouldHaveTwoCharacters
{
    NSDictionary *dict = @{
            @"offset": @123,
            @"total": @456,
            @"results": @[
                @{ @"name": @"ONE" },
                @{ @"name": @"TWO" },
            ],
    };
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
    
    assertThat(response.characters, containsIn(@[
            hasProperty(@"name", @"ONE"),
            hasProperty(@"name", @"TWO"),
    ]));
}

- (void)testBuild_WithRequiredFieldsButNoResults_ShouldHaveEmptyCharactersArray
{
    NSDictionary *dict = @{
            @"offset": @123,
            @"total": @456,
    };
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    QCOCharacterSliceResponseModel *response = [sut build];
    
    assertThat(response.characters, isEmpty());
}

- (void)testBuildCharacters_WithTwoResults_ShouldBuildTwoCharacters
{
    NSDictionary *dict = @{ @"results": @[
            @{ @"name": @"ONE" },
            @{ @"name": @"TWO" },
    ] };
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    NSArray<QCOCharacterResponseModel *> *characters = [sut buildCharacters];
    
    assertThat(characters, containsIn(@[
            hasProperty(@"name", @"ONE"),
            hasProperty(@"name", @"TWO"),
    ]));
}

- (void)testBuildCharacters_WithTwoResultsButFirstCharacterMissingName_ShouldBuildOneCharacter
{
    NSDictionary *dict = @{ @"results": @[
            @{},
            @{ @"name": @"TWO" },
    ] };
    QCOCharactersSliceResponseBuilder *sut = [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
    
    NSArray<QCOCharacterResponseModel *> *characters = [sut buildCharacters];
    
    assertThat(characters, containsIn(@[
            hasProperty(@"name", @"TWO"),
    ]));
}

@end
