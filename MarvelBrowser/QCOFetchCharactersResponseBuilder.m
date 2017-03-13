//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (void)parseJSONData:(NSData *)jsonData
{
    NSDictionary *dict = [self requireDictionary:[NSJSONSerialization JSONObjectWithData:jsonData
                                                                                 options:(NSJSONReadingOptions)0
                                                                                   error:NULL]];
    if (!dict)
        return;
    self.code = [self requireNumber:dict[@"code"]];
    self.status = [self requireString:dict[@"status"]];
}

- (NSDictionary *)requireDictionary:(id)object
{
    return QCORequireDictionary(object);
}

- (NSNumber *)requireNumber:(id)object
{
    return QCORequireNumber(object);
}

- (NSString *)requireString:(id)object
{
    return QCORequireString(object);
}

- (QCOFetchCharactersResponseModel *)build
{
    return nil;
}

@end
