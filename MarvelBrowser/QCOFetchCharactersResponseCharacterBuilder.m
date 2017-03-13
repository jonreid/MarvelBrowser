//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseCharacterBuilder.h"

#import "QCOBuilderUtils.h"


@implementation QCOFetchCharactersResponseCharacterBuilder

- (void)parseDictionary:(NSDictionary *)dict
{
    self.name = QCORequireString(dict[@"name"]);
}

@end
