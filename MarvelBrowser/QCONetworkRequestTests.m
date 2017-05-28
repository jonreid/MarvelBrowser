#import "QCONetworkRequest.h"

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

@end
