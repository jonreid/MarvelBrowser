//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseDataBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOFetchCharactersResponseCharacterBuilder.h"


@implementation QCOFetchCharactersResponseDataBuilder

- (void)parseDictionary:(NSDictionary *)dict
{
    self.offset = QCORequireNumber(dict[@"offset"]);
    self.limit = QCORequireNumber(dict[@"limit"]);
    self.total = QCORequireNumber(dict[@"total"]);
    self.count = QCORequireNumber(dict[@"count"]);
    self.results = [self parseResultsFromObject:dict[@"results"]];
}

- (NSArray<QCOFetchCharactersResponseCharacterBuilder *> *)parseResultsFromObject:(id)object
{
    NSArray *array = QCORequireArray(object);
    if (!array)
        return nil;
    return [self parseResultsFromArray:array];
}

- (NSArray<QCOFetchCharactersResponseCharacterBuilder *> *)parseResultsFromArray:(NSArray *)array
{
    NSMutableArray<QCOFetchCharactersResponseCharacterBuilder *> *accumulator = [[NSMutableArray alloc] init];
    for (id result in array)
        [self addDictionary:QCORequireDictionary(result) to:accumulator];
    return accumulator;
}

- (void)addDictionary:(NSDictionary *)dict
                   to:(NSMutableArray<QCOFetchCharactersResponseCharacterBuilder *> *)accumulator
{
    if (!dict)
        return;
    QCOFetchCharactersResponseCharacterBuilder *builder = [[QCOFetchCharactersResponseCharacterBuilder alloc] init];
    [builder parseDictionary:dict];
    [accumulator addObject:builder];
}

@end
