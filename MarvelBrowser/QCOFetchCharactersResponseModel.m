//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseModel

- (instancetype)initWithCode:(NSInteger)code status:(NSString *)status offset:(NSInteger)offset
{
    self = [super init];
    if (self)
    {
        _code = code;
        _status = [status copy];
        _offset = offset;
    }
    
    return self;
}


@end
