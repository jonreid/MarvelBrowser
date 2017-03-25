//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharacterResponseModel;
@class QCOCharacterSliceResponseModel;


@interface QCOFetchCharactersResponseModel : NSObject

@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, strong) QCOCharacterSliceResponseModel *slice;
@property (nonatomic, assign, readonly) NSInteger offset;
@property (nonatomic, assign, readonly) NSInteger total;
@property (nonatomic, copy, readonly) NSArray<QCOCharacterResponseModel *> *characters;

- (instancetype)initWithCode:(NSInteger)code status:(NSString *)status slice:(QCOCharacterSliceResponseModel *)slice offset:(NSInteger)offset total:(NSInteger)total characters:(NSArray<QCOCharacterResponseModel *> *)characters;

@end
