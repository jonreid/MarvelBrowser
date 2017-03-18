//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOCharacterResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOCharacterResponse.h"


@implementation QCOCharacterResponseBuilder

- (void)parseDictionary:(NSDictionary *)dict
{
    self.name = QCORequireString(dict[@"name"]);
}

- (QCOCharacterResponse *)build
{
    return nil;
}

@end
