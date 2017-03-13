//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOBuilderUtils.h"


static id requireType(id object, Class type) {
    if (![object isKindOfClass:type])
        return nil;
    return object;
}

NSArray *QCORequireArray(id object)
{
    return requireType(object, [NSArray class]);
}

NSDictionary *QCORequireDictionary(id object)
{
    return requireType(object, [NSDictionary class]);
}

NSNumber *QCORequireNumber(id object)
{
    return requireType(object, [NSNumber class]);
}

NSString *QCORequireString(id object)
{
    return requireType(object, [NSString class]);
}
