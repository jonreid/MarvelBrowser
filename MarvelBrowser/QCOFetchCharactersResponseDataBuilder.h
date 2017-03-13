//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface QCOFetchCharactersResponseDataBuilder : NSObject

@property (nonatomic, strong) NSNumber *offset;

- (void)parseDictionary:(NSDictionary *)dict;

@end
