//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (QCOFetchCharactersResponseModel *)parseJSONData:(NSData *)jsonData
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    NSNumber *code = dict[@"code"];
    return [[QCOFetchCharactersResponseModel alloc] initWithCode:code.integerValue];
}

@end
