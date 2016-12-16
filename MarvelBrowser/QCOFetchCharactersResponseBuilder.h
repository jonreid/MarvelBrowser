//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOFetchCharactersResponseModel;


@interface QCOFetchCharactersResponseBuilder : NSObject

- (QCOFetchCharactersResponseModel *)parseJSONData:(NSData *)jsonData;

@end
