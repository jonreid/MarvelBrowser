//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharacterResponse;
@class QCOCharacterResponseBuilder;


@interface QCOFetchCharactersResponseDataBuilder : NSObject

@property (nonatomic, strong) NSNumber *offset;
@property (nonatomic, strong) NSNumber *limit;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, copy) NSArray<QCOCharacterResponseBuilder *> *results;

- (void)parseDictionary:(NSDictionary *)dict;
- (NSArray<QCOCharacterResponse *> *)buildCharacters;

@end
