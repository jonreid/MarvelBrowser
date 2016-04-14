//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersMarvelService.h"

#import "QCOFetchCharactersRequestModel.h"

#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import <XCTest/XCTest.h>


@interface QCOFetchCharactersMarvelServiceTests : XCTestCase
@end

@implementation QCOFetchCharactersMarvelServiceTests
{
    NSURLSession *mockSession;
    QCOFetchCharactersMarvelService *sut;
}

- (void)setUp
{
    [super setUp];
    mockSession = mock([NSURLSession class]);
    sut = [[QCOFetchCharactersMarvelService alloc] initWithSession:mockSession];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (QCOFetchCharactersRequestModel *)dummyRequestModel
{
    return [[QCOFetchCharactersRequestModel alloc]
            initWithNamePrefix:@"DUMMY" pageSize:10 offset:30];
}

- (void)testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint
{
    QCOFetchCharactersRequestModel *requestModel = [self dummyRequestModel];

    [sut fetchCharacters:requestModel];

    [verify(mockSession) dataTaskWithURL:hasProperty(@"host", @"gateway.marvel.com")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_ShouldMakeDataTaskWithSecureConnection
{
    QCOFetchCharactersRequestModel *requestModel = [self dummyRequestModel];

    [sut fetchCharacters:requestModel];

    [verify(mockSession) dataTaskWithURL:hasProperty(@"scheme", @"https")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_ShouldMakeDataTaskForCharactersAPI
{
    QCOFetchCharactersRequestModel *requestModel = [self dummyRequestModel];

    [sut fetchCharacters:requestModel];

    [verify(mockSession) dataTaskWithURL:hasProperty(@"path", @"/v1/public/characters")
                       completionHandler:anything()];
}

@end
