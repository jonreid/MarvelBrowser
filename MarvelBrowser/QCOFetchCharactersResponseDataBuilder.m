//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseModel.h"

#import "QCOBuilderUtils.h"
#import "QCOCharacterResponseBuilder.h"
#import "QCOFetchCharactersResponseDataBuilder.h"


@implementation QCOFetchCharactersResponseDataBuilder

- (void)parseDictionary:(NSDictionary *)dict
{
    self.offset = QCORequireNumber(dict[@"offset"]);
    self.total = QCORequireNumber(dict[@"total"]);
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

- (NSArray<QCOCharacterResponse *> *)buildCharacters
{
    NSMutableArray<QCOCharacterResponse *> *characters = [[NSMutableArray alloc] init];
    for (QCOCharacterResponseBuilder *builder in self.results)
        [characters addObject:[builder build]];
    return characters;
}

@end
