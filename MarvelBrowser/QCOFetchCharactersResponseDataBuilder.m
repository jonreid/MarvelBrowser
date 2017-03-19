//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseModel.h"

#import "QCOBuilderUtils.h"
#import "QCOCharacterResponseBuilder.h"
#import "QCOFetchCharactersResponseDataBuilder.h"


@implementation QCOFetchCharactersResponseDataBuilder

- (instancetype)initWithDictionary:(NSDictionary *)dict;
{
    self = [super init];
    if (self)
    {
        _offset = QCORequireNumber(dict[@"offset"]);
        _total = QCORequireNumber(dict[@"total"]);
        _results = [[self parseResultsFromArray:QCORequireArray(dict[@"results"])] copy];
    }
    return self;
}

- (NSArray<QCOCharacterResponseBuilder *> *)parseResultsFromArray:(NSArray *)array
{
    if (!array)
        return nil;
    NSMutableArray<QCOCharacterResponseBuilder *> *accumulator = [[NSMutableArray alloc] init];
    for (id result in array)
        [self appendResult:result toAccumulator:accumulator];
    return accumulator;
}

- (void)appendResult:(id)result
       toAccumulator:(NSMutableArray<QCOCharacterResponseBuilder *> *)accumulator
{
    NSDictionary *dict = QCORequireDictionary(result);
    if (dict)
        [accumulator addObject:[[QCOCharacterResponseBuilder alloc] initWithDictionary:dict]];
}

- (NSArray<QCOCharacterResponse *> *)buildCharacters
{
    NSMutableArray<QCOCharacterResponse *> *characters = [[NSMutableArray alloc] init];
    for (QCOCharacterResponseBuilder *builder in self.results) {
        QCOCharacterResponse *character = [builder build];
        if (character)
            [characters addObject:character];
    }
    return characters;
}

@end
