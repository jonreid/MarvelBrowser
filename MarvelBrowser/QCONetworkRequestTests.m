#import "QCONetworkRequest.h"

#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import <XCTest/XCTest.h>


@interface QCONetworkRequestTests : XCTestCase
@end

@implementation QCONetworkRequestTests
{
    id mockTask;
}

- (void)setUp
{
    [super setUp];
    mockTask = mock([NSURLSessionTask class]);
}

- (void)tearDown
{
    mockTask = nil;
    [super tearDown];
}

- (void)testStartTask_ShouldTellTaskToResume
{
    QCONetworkRequest *sut = [[QCONetworkRequest alloc] init];
    
    [sut startTask:mockTask];
    
    [verify(mockTask) resume];
}

- (void)testStartTask_ShouldRetainGivenTask
{
    QCONetworkRequest *sut = [[QCONetworkRequest alloc] init];
    
    [sut startTask:mockTask];
    
    assertThat(sut.currentTask, is(sameInstance(mockTask)));
}

@end
