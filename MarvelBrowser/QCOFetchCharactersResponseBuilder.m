//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOCharactersSliceResponseBuilder.h"
#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _code = QCORequireNumber(dict[@"code"]);
        _status = [QCORequireString(dict[@"status"]) copy];
        _data = [[self class] parseDataFromDictionary:QCORequireDictionary(dict[@"data"])];
    }
    return self;
}

+ (QCOCharactersSliceResponseBuilder *)parseDataFromDictionary:(NSDictionary *)dict
{
    if (!dict)
        return nil;
    return [[QCOCharactersSliceResponseBuilder alloc] initWithDictionary:dict];
}

- (QCOFetchCharactersResponseModel *)build
{
    QCOCharacterSliceResponseModel *slice = [self.data build];
    BOOL validCodeButNoData = [self.code isEqualToNumber:@200] && !slice;
    if (self.code == nil || validCodeButNoData)
        self.code = @500;
    return [[QCOFetchCharactersResponseModel alloc] initWithCode:self.code.integerValue
                                                          status:self.status
                                                           slice:slice];
}

@end
