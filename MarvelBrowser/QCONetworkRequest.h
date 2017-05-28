//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface QCONetworkRequest : NSObject

@property (nonatomic, strong, readonly) NSURLSessionTask *currentTask;

- (void)startTask:(NSURLSessionTask *)task;
- (void)didComplete;
- (void)cancel;

@end
