//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCONetworkRequest.h"


@interface QCONetworkRequest ()
@property (nonatomic, strong, readwrite) NSURLSessionTask *currentTask;
@end

@implementation QCONetworkRequest

- (void)startTask:(NSURLSessionTask *)task
{
    NSAssert(self.currentTask == nil, @"startTask called more than once");
    self.currentTask = task;
    [self.currentTask resume];
}

- (void)didComplete
{
    self.currentTask = nil;
}

@end
