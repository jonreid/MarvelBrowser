//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharacterResponse;


@interface QCOFetchCharactersResponseModel : NSObject

@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, assign, readonly) NSInteger offset;
@property (nonatomic, assign, readonly) NSInteger total;
@property (nonatomic, copy, readonly) NSArray<QCOCharacterResponse *> *characters;

- (instancetype)initWithCode:(NSInteger)code
                      status:(NSString *)status
                      offset:(NSInteger)offset
                       total:(NSInteger)total
                  characters:(NSArray<QCOCharacterResponse *> *)characters;

@end
