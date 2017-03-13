//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOBuilderUtils.h"
#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (void)parseJSONData:(NSData *)jsonData
{
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:(NSJSONReadingOptions)0
                                                  error:NULL];
    NSDictionary *dict = QCORequireDictionary(object);
    if (!dict)
        return;
    self.code = QCORequireNumber(dict[@"code"]);
    self.status = QCORequireString(dict[@"status"]);
}

- (QCOFetchCharactersResponseModel *)build
{
    return nil;
}

@end
