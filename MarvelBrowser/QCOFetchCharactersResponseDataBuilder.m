//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseDataBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOCharacterResponseBuilder.h"


@implementation QCOFetchCharactersResponseDataBuilder

- (void)parseDictionary:(NSDictionary *)dict
{
    self.offset = QCORequireNumber(dict[@"offset"]);
    self.limit = QCORequireNumber(dict[@"limit"]);
    self.total = QCORequireNumber(dict[@"total"]);
    self.count = QCORequireNumber(dict[@"count"]);
    self.results = [self parseResultsFromArray:QCORequireArray(dict[@"results"])];
}

- (NSArray<QCOCharacterResponseBuilder *> *)parseResultsFromArray:(NSArray *)array
{
    if (!array)
        return nil;
    NSMutableArray<QCOCharacterResponseBuilder *> *accumulator = [[NSMutableArray alloc] init];
    for (id result in array)
        [self addDictionary:QCORequireDictionary(result) to:accumulator];
    return accumulator;
}

- (void)addDictionary:(NSDictionary *)dict
                   to:(NSMutableArray<QCOCharacterResponseBuilder *> *)accumulator
{
    if (!dict)
        return;
    QCOCharacterResponseBuilder *builder = [[QCOCharacterResponseBuilder alloc] init];
    [builder parseDictionary:dict];
    [accumulator addObject:builder];
}

@end
