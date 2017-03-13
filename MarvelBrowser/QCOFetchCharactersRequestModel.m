//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersRequestModel.h"


@implementation QCOFetchCharactersRequestModel

- (instancetype)initWithNamePrefix:(NSString *)namePrefix
                          pageSize:(NSUInteger)pageSize
                            offset:(NSUInteger)offset
{
    self = [super init];
    if (self)
    {
        _namePrefix = [namePrefix copy];
        _pageSize = pageSize;
        _offset = offset;
    }
    return self;
}

@end
