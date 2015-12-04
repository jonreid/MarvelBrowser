//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelService.h"


@implementation QCOMarvelService

- (NSURLSessionConfiguration *)sessionConfiguration
{
    if (!_sessionConfiguration) {
        _sessionConfiguration = [[NSURLSessionConfiguration alloc] init];
    }
    return _sessionConfiguration;
}

@end
