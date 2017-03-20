//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOFetchCharactersResponseDataBuilder.h"
#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (void)parseDictionary:(NSDictionary *)dict
{
    if (!dict)
        return;
    self.code = QCORequireNumber(dict[@"code"]);
    self.status = QCORequireString(dict[@"status"]);
    self.data = [self parseDataFromDictionary:QCORequireDictionary(dict[@"data"])];
}

- (QCOFetchCharactersResponseDataBuilder *)parseDataFromDictionary:(NSDictionary *)dict
{
    if (!dict)
        return nil;
    return [[QCOFetchCharactersResponseDataBuilder alloc] initWithDictionary:dict];
}

- (QCOFetchCharactersResponseModel *)build
{
    if (!self.code)
        return nil;
    return [[QCOFetchCharactersResponseModel alloc] initWithCode:self.code.integerValue
                                                          status:self.status
                                                          offset:self.data.offset.integerValue
                                                           total:self.data.total.integerValue
                                                      characters:[self.data buildCharacters]];
}

@end
