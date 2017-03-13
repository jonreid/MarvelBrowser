//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

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
    if (![object isKindOfClass:[NSDictionary class]])
        return nil;
    return object;
}

- (NSNumber *)requireNumber:(id)object
{
    if (![object isKindOfClass:[NSNumber class]])
        return nil;
    return object;
}

- (NSString *)requireString:(id)object
{
    if (![object isKindOfClass:[NSString class]])
        return nil;
    return object;
}

- (QCOFetchCharactersResponseModel *)build
{
    return nil;
}

@end
