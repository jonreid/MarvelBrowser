//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseDataBuilder.h"


@implementation QCOFetchCharactersResponseDataBuilder

- (void)parseDictionary:(NSDictionary *)dict
{
    self.offset = [self requireNumber:dict[@"offset"]];
}

- (NSNumber *)requireNumber:(id)object
{
    if (![object isKindOfClass:[NSNumber class]])
        return nil;
    return object;
}

@end
