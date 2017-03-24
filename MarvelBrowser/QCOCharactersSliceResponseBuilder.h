//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharacterResponseModel;
@class QCOCharacterResponseBuilder;


@interface QCOCharactersSliceResponseBuilder : NSObject

@property (nonatomic, strong, readonly) NSNumber *offset;
@property (nonatomic, strong, readonly) NSNumber *total;
@property (nonatomic, copy, readonly) NSArray<QCOCharacterResponseBuilder *> *results;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSArray<QCOCharacterResponseModel *> *)buildCharacters;

@end
