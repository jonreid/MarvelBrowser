//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersMarvelService.h"

#import "QCOFetchCharactersRequestModel.h"

#import "QCOURLQueryMatcher.h"
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

    [sut fetchCharactersWithRequestModel:requestModel];

    [verify(mockSession) dataTaskWithURL:hasProperty(@"host", @"gateway.marvel.com")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_ShouldMakeDataTaskWithSecureConnection
{
    QCOFetchCharactersRequestModel *requestModel = [self dummyRequestModel];

    [sut fetchCharactersWithRequestModel:requestModel];

    [verify(mockSession) dataTaskWithURL:hasProperty(@"scheme", @"https")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_ShouldMakeDataTaskForCharactersAPI
{
    QCOFetchCharactersRequestModel *requestModel = [self dummyRequestModel];

    [sut fetchCharactersWithRequestModel:requestModel];

    [verify(mockSession) dataTaskWithURL:hasProperty(@"path", @"/v1/public/characters")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_WithNamePrefix_ShouldMakeDataTaskWithQueryForNameStartsWith
{
    QCOFetchCharactersRequestModel *requestModel = [[QCOFetchCharactersRequestModel alloc]
            initWithNamePrefix:@"NAME" pageSize:10 offset:30];

    [sut fetchCharactersWithRequestModel:requestModel];

    [verify(mockSession) dataTaskWithURL:hasQuery(@"nameStartsWith", @"NAME")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_WithNamePrefix_ShouldPercentEncodeNameStartsWith
{
    QCOFetchCharactersRequestModel *requestModel = [[QCOFetchCharactersRequestModel alloc]
            initWithNamePrefix:@"ab cd" pageSize:10 offset:30];

    [sut fetchCharactersWithRequestModel:requestModel];

    [verify(mockSession) dataTaskWithURL:hasQuery(@"nameStartsWith", @"ab%20cd")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_WithPageSize_ShouldMakeDataTaskWithQueryForLimit
{
    QCOFetchCharactersRequestModel *requestModel = [[QCOFetchCharactersRequestModel alloc]
            initWithNamePrefix:@"DUMMY" pageSize:10 offset:30];

    [sut fetchCharactersWithRequestModel:requestModel];

    [verify(mockSession) dataTaskWithURL:hasQuery(@"limit", @"10")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_WithOffset_ShouldMakeDataTaskWithQueryForOffset
{
    QCOFetchCharactersRequestModel *requestModel = [[QCOFetchCharactersRequestModel alloc]
            initWithNamePrefix:@"DUMMY" pageSize:10 offset:30];

    [sut fetchCharactersWithRequestModel:requestModel];

    [verify(mockSession) dataTaskWithURL:hasQuery(@"offset", @"30")
                       completionHandler:anything()];
}

@end
