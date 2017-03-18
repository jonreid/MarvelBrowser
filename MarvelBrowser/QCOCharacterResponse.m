//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharacterResponse.h"


@implementation QCOCharacterResponse

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
        _name = [name copy];
    return self;
}

@end
