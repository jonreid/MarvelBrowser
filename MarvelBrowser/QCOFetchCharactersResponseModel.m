//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseModel

- (instancetype)initWithCode:(NSInteger)code status:(NSString *)status offset:(NSInteger)offset limit:(NSInteger)limit total:(NSInteger)total count:(NSInteger)count characters:(NSArray<QCOCharacterResponse *> *)characters
{
    self = [super init];
    if (self)
    {
        _code = code;
        _status = [status copy];
        _offset = offset;
        _limit = limit;
        _total = total;
        _count = count;
        _characters = [characters copy];
    }
    return self;
}

@end
