//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharactersSliceResponseBuilder;
@class QCOFetchCharactersResponseModel;


@interface QCOFetchCharactersResponseBuilder : NSObject

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, strong, readonly) QCOCharactersSliceResponseBuilder *data;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (QCOFetchCharactersResponseModel *)build;

@end
