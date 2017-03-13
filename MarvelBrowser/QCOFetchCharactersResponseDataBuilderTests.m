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
    NSDictionary *dict = @{@"offset": @"123"};
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] init];
    
    [sut parseDictionary:dict];
    
    NSNumber *result = sut.offset;
    assertThat(result, is(nilValue()));
}

- (void)testParseDictionary_WithOffset_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{@"offset": @123};
    QCOFetchCharactersResponseDataBuilder *sut = [[QCOFetchCharactersResponseDataBuilder alloc] init];
    
    [sut parseDictionary:dict];
    
    NSNumber *result = sut.offset;
    assertThat(result, is(@123));
}

@end
