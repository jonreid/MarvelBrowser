//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseDataBuilder.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOFetchCharactersResponseDataBuilderTests : XCTestCase
@end

@implementation QCOFetchCharactersResponseDataBuilderTests

- (void)testParseDictionary_WithNonIntegerOffset_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"offset": @"123" };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.offset, is(nilValue()));
}

- (void)testParseDictionary_WithOffset_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"offset": @123 };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.offset, is(@123));
}

- (void)testParseDictionary_WithNonIntegerTotal_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"total": @"123" };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.total, is(nilValue()));
}

- (void)testParseDictionary_WithTotal_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{ @"total": @123 };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.total, is(@123));
}

- (void)testParseDictionary_WithNonArrayResult_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{ @"results":
            @{ @"name": @"DUMMY" }
    };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, is(nilValue()));
}

- (void)testParseDictionary_WithOneResultThatIsNotDictionary_ShouldCaptureArraySizeZeroInBuilder
{
    NSDictionary *dict = @{ @"results": @[
            @[ @"DUMMY" ],
    ] };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, hasCountOf(0));
}

- (void)testParseDictionary_WithOneResult_ShouldCaptureOneCharacterInBuilder
{
    NSDictionary *dict = @{ @"results": @[
            @{ @"name": @"ONE" },
    ] };
    
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
    
    assertThat(sut.results, containsIn(@[
            hasProperty(@"name", @"ONE"),
    ]));
}

- (void)testParseDictionary_WithTwoResult_ShouldCaptureTwoCharactersInBuilder
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

@end
