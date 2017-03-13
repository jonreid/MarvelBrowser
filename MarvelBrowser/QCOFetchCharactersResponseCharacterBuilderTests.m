//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseCharacterBuilder.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOFetchCharactersResponseCharacterBuilderTests : XCTestCase
@end

@implementation QCOFetchCharactersResponseCharacterBuilderTests
{
    QCOFetchCharactersResponseCharacterBuilder *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[QCOFetchCharactersResponseCharacterBuilder alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testParseDictionary_WithNonStringName_ShouldCaptureNilInBuilder
{
    NSDictionary *dict = @{@"name": @123};
    
    [sut parseDictionary:dict];
    
    assertThat(sut.name, is(nilValue()));
}

- (void)testParseDictionary_WithName_ShouldCaptureValueInBuilder
{
    NSDictionary *dict = @{@"name": @"NAME"};
    
    [sut parseDictionary:dict];
    
    assertThat(sut.name, is(@"NAME"));
}

@end
