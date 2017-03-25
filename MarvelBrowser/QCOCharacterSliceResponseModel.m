//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharacterSliceResponseModel.h"


@implementation QCOCharacterSliceResponseModel

- (instancetype)initWithOffset:(NSInteger)offset total:(NSInteger)total characters:(NSArray<QCOCharacterResponseModel *> *)characters
{
    self = [super init];
    if (self)
    {
        _offset = offset;
        _total = total;
        _characters = [characters copy];
    }
    return self;
}

@end
