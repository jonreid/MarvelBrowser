#import "QCONetworkRequest.h"

#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import <XCTest/XCTest.h>


@interface QCONetworkRequestTests : XCTestCase
@end

@implementation QCONetworkRequestTests

- (void)testStartTask_ShouldTellTaskToResume
{
    id mockTask = mock([NSURLSessionTask class]);
    QCONetworkRequest *sut = [[QCONetworkRequest alloc] init];
    
    [sut startTask:mockTask];
    
    [verify(mockTask) resume];
}

- (void)testStartTask_ShouldRetainGivenTask
{
    id mockTask = mock([NSURLSessionTask class]);
    QCONetworkRequest *sut = [[QCONetworkRequest alloc] init];
    
    [sut startTask:mockTask];
    
    assertThat(sut.currentTask, is(sameInstance(mockTask)));
}

@end
