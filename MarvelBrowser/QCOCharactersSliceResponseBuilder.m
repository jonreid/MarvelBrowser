//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseModel.h"

#import "QCOBuilderUtils.h"
#import "QCOCharacterResponseBuilder.h"
#import "QCOCharactersSliceResponseBuilder.h"


@implementation QCOCharactersSliceResponseBuilder

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

- (NSArray<QCOCharacterResponseModel *> *)buildCharacters
{
    NSMutableArray<QCOCharacterResponseModel *> *characters = [[NSMutableArray alloc] init];
    for (QCOCharacterResponseBuilder *builder in self.results)
        [self appendBuiltModelFrom:builder toAccumulator:characters];
    return characters;
}

- (void)appendBuiltModelFrom:(QCOCharacterResponseBuilder *)builder
               toAccumulator:(NSMutableArray<QCOCharacterResponseModel *> *)accumulator
{
    QCOCharacterResponseModel *product = [builder build];
    if (product)
        [accumulator addObject:product];
}

@end
