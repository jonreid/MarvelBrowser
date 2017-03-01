//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (QCOFetchCharactersResponseModel *)parseJSONData:(NSData *)jsonData
{
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:(NSJSONReadingOptions)0
                                                  error:NULL];
    if (![object isKindOfClass:[NSDictionary class]])
        return nil;
    NSDictionary *dict = object;
    
    id attr = dict[@"code"];
    if (![attr isKindOfClass:[NSNumber class]])
        return nil;
    NSNumber *code = attr;
    return [[QCOFetchCharactersResponseModel alloc] initWithCode:code.integerValue];
}

@end
