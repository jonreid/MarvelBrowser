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
    NSArray *r = dict[@"results"];
    NSDictionary *c = r[0];
    QCOFetchCharactersResponseCharacterBuilder *characterBuilder = [[QCOFetchCharactersResponseCharacterBuilder alloc] init];
    [characterBuilder parseDictionary:c];
    self.results = @[characterBuilder];
}

@end
