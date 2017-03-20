//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOFetchCharactersResponseDataBuilder;
@class QCOFetchCharactersResponseModel;


@interface QCOFetchCharactersResponseBuilder : NSObject

@property (nonatomic, strong, readonly) NSNumber *code;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, strong, readonly) QCOFetchCharactersResponseDataBuilder *data;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (QCOFetchCharactersResponseModel *)build;

@end
