//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/#import "QCOFetchCharactersResponseModel.h"
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOParseFetchCharactersJSONData.h"

#import "QCOBuilderUtils.h"
#import "QCOFetchCharactersResponseBuilder.h"


QCOFetchCharactersResponseModel *QCOParseFetchCharactersJSONData(NSData *jsonData)
{
    QCOFetchCharactersResponseBuilder *builder = [[QCOFetchCharactersResponseBuilder alloc] init];
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:(NSJSONReadingOptions)0
                                                  error:NULL];
    [builder parseDictionary:QCORequireDictionary(object)];
    return [builder build];
}
