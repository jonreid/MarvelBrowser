//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOBuilderUtils.h"


NSDictionary *QCORequireDictionary(id object)
{
    if (![object isKindOfClass:[NSDictionary class]])
        return nil;
    return object;
}

NSNumber *QCORequireNumber(id object)
{
    if (![object isKindOfClass:[NSNumber class]])
        return nil;
    return object;
}

NSString *QCORequireString(id object)
{
    if (![object isKindOfClass:[NSString class]])
        return nil;
    return object;
}
