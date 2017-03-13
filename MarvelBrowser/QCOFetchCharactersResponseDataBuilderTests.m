//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseDataBuilder.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOFetchCharactersResponseDataBuilderTests : XCTestCase
@end

@implementation QCOFetchCharactersResponseDataBuilderTests
{
    QCOFetchCharactersResponseDataBuilder *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[QCOFetchCharactersResponseDataBuilder alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testParseDictionary_WithNonIntegerOffset_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{@"offset": @"123"};
    
    [sut parseDictionary:dict];
    
    assertThat(sut.offset, is(nilValue()));
}

- (void)testParseDictionary_WithOffset_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{@"offset": @123};
    
    [sut parseDictionary:dict];
    
    assertThat(sut.offset, is(@123));
}

- (void)testParseDictionary_WithNonIntegerLimit_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{@"limit": @"123"};
    
    [sut parseDictionary:dict];
    
    assertThat(sut.limit, is(nilValue()));
}

- (void)testParseDictionary_WithLimit_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{@"limit": @123};
    
    [sut parseDictionary:dict];
    
    assertThat(sut.limit, is(@123));
}

@end
