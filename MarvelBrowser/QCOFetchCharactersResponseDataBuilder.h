//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOFetchCharactersResponseCharacterBuilder;


@interface QCOFetchCharactersResponseDataBuilder : NSObject

@property (nonatomic, strong) NSNumber *offset;
@property (nonatomic, strong) NSNumber *limit;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, copy) NSArray<QCOFetchCharactersResponseCharacterBuilder *> *results;

- (void)parseDictionary:(NSDictionary *)dict;

@end
