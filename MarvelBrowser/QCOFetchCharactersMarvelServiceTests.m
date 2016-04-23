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
    NSURLSessionDataTask *mockDataTask;
}

- (void)setUp
{
    [super setUp];
    mockSession = mock([NSURLSession class]);
    sut = [[QCOFetchCharactersMarvelService alloc] initWithSession:mockSession
                                           authParametersGenerator:^NSString * {
                                               return @"";
                                           }];
    mockDataTask = mock([NSURLSessionDataTask class]);
}

- (void)tearDown
{
    mockSession = nil;
    sut = nil;
    mockDataTask = nil;
    [super tearDown];
}

- (QCOFetchCharactersRequestModel *)dummyRequestModel
{
    return [[QCOFetchCharactersRequestModel alloc]
            initWithNamePrefix:@"DUMMY" pageSize:10 offset:30];
}

- (void)testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint
{

    [sut fetchCharactersWithRequestModel:[self dummyRequestModel]];

    [verify(mockSession) dataTaskWithURL:hasProperty(@"host", @"gateway.marvel.com")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_ShouldMakeDataTaskWithSecureConnection
{

    [sut fetchCharactersWithRequestModel:[self dummyRequestModel]];

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

- (void)testFetchCharacters_ShouldIncludeGeneratedAuthenticationParameters
{
    QCOFetchCharactersMarvelService *sutWithAuthParameters =
            [[QCOFetchCharactersMarvelService alloc] initWithSession:mockSession
                                             authParametersGenerator:^NSString * {
                                                 return @"&FOO=BAR";
                                             }];

    [sutWithAuthParameters fetchCharactersWithRequestModel:[self dummyRequestModel]];

    [verify(mockSession) dataTaskWithURL:hasQuery(@"FOO", @"BAR")
                       completionHandler:anything()];
}

- (void)testFetchCharacters_ShouldStartDataTask
{
    [given([mockSession dataTaskWithURL:anything() completionHandler:anything()])
            willReturn:mockDataTask];

    [sut fetchCharactersWithRequestModel:[self dummyRequestModel]];

    [verify(mockDataTask) resume];
}

- (void)testFetchCharacters_ShouldHoldDataTaskAsPropertyToKeepTaskAlive
{
    [given([mockSession dataTaskWithURL:anything() completionHandler:anything()])
            willReturn:mockDataTask];

    [sut fetchCharactersWithRequestModel:[self dummyRequestModel]];

    assertThat(sut.dataTask, is(sameInstance(mockDataTask)));
}

- (void)testCancel_AfterFetch_ShouldCancelDataTask
{
    [given([mockSession dataTaskWithURL:anything() completionHandler:anything()])
            willReturn:mockDataTask];
    [sut fetchCharactersWithRequestModel:[self dummyRequestModel]];

    [sut cancel];

    [verify(mockDataTask) cancel];
}

- (void)testCancel_AfterFetch_ShouldReleaseDataTask
{
    [given([mockSession dataTaskWithURL:anything() completionHandler:anything()])
            willReturn:mockDataTask];
    [sut fetchCharactersWithRequestModel:[self dummyRequestModel]];

    [sut cancel];

    assertThat(sut.dataTask, is(nilValue()));
}

- (void)testAttemptingSecondFetch_WithOneInProgress_ShouldRaiseException
{
    [given([mockSession dataTaskWithURL:anything() completionHandler:anything()])
            willReturn:mockDataTask];
    [sut fetchCharactersWithRequestModel:[self dummyRequestModel]];

    assertThat(^{ [sut fetchCharactersWithRequestModel:[self dummyRequestModel]]; },
            throwsException(anything()));
}

@end
