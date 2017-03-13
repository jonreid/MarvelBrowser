//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOFetchCharactersResponseDataBuilder.h"
#import "QCOFetchCharactersResponseModel.h"


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
    return nil;
}

@end
