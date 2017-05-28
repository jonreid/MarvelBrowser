//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCONetworkRequest.h"


@interface QCONetworkRequest ()
@property (nonatomic, strong, readwrite) NSURLSessionTask *currentTask;
@end

@implementation QCONetworkRequest

- (void)startTask:(NSURLSessionTask *)task
{
    self.currentTask = task;
    [task resume];
}

@end
