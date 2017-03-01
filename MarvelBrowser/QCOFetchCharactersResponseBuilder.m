//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (QCOFetchCharactersResponseModel *)parseJSONData:(NSData *)jsonData
{
    NSDictionary *dict = [self requireDictionary:[NSJSONSerialization JSONObjectWithData:jsonData
                                                                                 options:(NSJSONReadingOptions)0
                                                                                   error:NULL]];
    if (!dict)
        return nil;
    NSNumber *code = [self requireNumber:dict[@"code"]];
    if (!code)
        return nil;
    return [[QCOFetchCharactersResponseModel alloc] initWithCode:code.integerValue];
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

@end
