//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseDataBuilder.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOFetchCharactersResponseDataBuilderTests : XCTestCase
@end

@implementation QCOFetchCharactersResponseDataBuilderTests

- (void)testInit_WithNonIntegerOffset_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"offset": @"123" };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.offset, is(nilValue()));
}

- (void)testInit_WithOffset_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"offset": @123 };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.offset, is(@123));
}

- (void)testInit_WithNonIntegerTotal_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"total": @"123" };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.total, is(nilValue()));
}

- (void)testInit_WithTotal_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"total": @123 };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.total, is(@123));
}

- (void)testInit_WithNonArrayResult_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"results":
            @{ @"name": @"DUMMY" }
    };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, is(nilValue()));
}

- (void)testInit_WithOneResultThatIsNotDictionary_ShouldCaptureArraySizeZeroInBuilder
{
    NSDictionary *dict = @{ @"results": @[
            @[ @"DUMMY" ],
    ] };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, hasCountOf(0));
}

- (void)testInit_WithOneResult_ShouldCaptureOneCharacterInBuilder
{
    NSDictionary *dict = @{ @"results": @[
            @{ @"name": @"ONE" },
    ] };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
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
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, containsIn(@[
            hasProperty(@"name", @"ONE"),
            hasProperty(@"name", @"TWO"),
    ]));
}

- (void)testBuildCharacters_WithTwoResults_ShouldBuildTwoCharacters
{
    NSDictionary *dict = @{ @"results": @[
            @{ @"name": @"ONE" },
            @{ @"name": @"TWO" },
    ] };
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    NSArray<QCOCharacterResponse *> *characters = [sut buildCharacters];
    
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
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    NSArray<QCOCharacterResponse *> *characters = [sut buildCharacters];
    
    assertThat(characters, containsIn(@[
            hasProperty(@"name", @"TWO"),
    ]));
}

@end
