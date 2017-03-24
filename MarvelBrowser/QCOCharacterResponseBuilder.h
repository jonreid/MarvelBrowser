//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharacterResponseModel;


@interface QCOCharacterResponseBuilder : NSObject

@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (QCOCharacterResponseModel *)build;

@end
