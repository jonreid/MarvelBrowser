//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOFetchCharactersResponseDataBuilder;
@class QCOFetchCharactersResponseModel;


@interface QCOFetchCharactersResponseBuilder : NSObject

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) QCOFetchCharactersResponseDataBuilder *data;

- (void)parseJSONData:(NSData *)jsonData;
- (QCOFetchCharactersResponseModel *)build;

@end
