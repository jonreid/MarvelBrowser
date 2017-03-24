//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharacterResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOCharacterResponseModel.h"


@implementation QCOCharacterResponseBuilder

- (instancetype)initWithDictionary:(NSDictionary *)dict;
{
    self = [super init];
    if (self)
        _name = [QCORequireString(dict[@"name"]) copy];
    return self;
}

- (QCOCharacterResponseModel *)build
{
    if (!self.name)
        return nil;
    return [[QCOCharacterResponseModel alloc] initWithName:self.name];
}

@end
