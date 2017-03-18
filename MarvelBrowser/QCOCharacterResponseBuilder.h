//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharacterResponse;


@interface QCOCharacterResponseBuilder : NSObject

@property (nonatomic, copy) NSString *name;

- (void)parseDictionary:(NSDictionary *)dict;
- (QCOCharacterResponse *)build;

@end
