//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOFetchCharactersResponseDataBuilder.h"
#import "QCOFetchCharactersResponseModel.h"
#import "QCOCharacterResponseBuilder.h"


@implementation QCOFetchCharactersResponseBuilder

- (void)parseJSONData:(NSData *)jsonData
{
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:(NSJSONReadingOptions)0
                                                  error:NULL];
    [self parseDictionary:QCORequireDictionary(object)];
}

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
    QCOFetchCharactersResponseDataBuilder *builder = [[QCOFetchCharactersResponseDataBuilder alloc] init];
    [builder parseDictionary:dict];
    return builder;
}

- (QCOFetchCharactersResponseModel *)build
{
    if (!self.code)
        return nil;
    NSMutableArray<QCOCharacterResponse *> *characters = [[NSMutableArray alloc] init];
    for (QCOCharacterResponseBuilder *builder in self.data.results) {
        [characters addObject:[builder build]];
    }
    return [[QCOFetchCharactersResponseModel alloc] initWithCode:self.code.integerValue
                                                          status:self.status
                                                          offset:self.data.offset.integerValue
                                                           limit:self.data.limit.integerValue
                                                           total:self.data.total.integerValue
                                                           count:self.data.count.integerValue
                                                      characters:characters];
}

@end
