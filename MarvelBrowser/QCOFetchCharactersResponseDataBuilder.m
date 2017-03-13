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
    NSArray *array = QCORequireArray(dict[@"results"]);
    if (!array)
        return;
    NSMutableArray *characterAccumulator = [[NSMutableArray alloc] init];
    NSDictionary *characterDict = QCORequireDictionary(array[0]);
    if (characterDict) {
        QCOFetchCharactersResponseCharacterBuilder *characterBuilder = [[QCOFetchCharactersResponseCharacterBuilder alloc] init];
        [characterBuilder parseDictionary:characterDict];
        [characterAccumulator addObject:characterBuilder];
    }
    self.results = characterAccumulator;
}

@end
