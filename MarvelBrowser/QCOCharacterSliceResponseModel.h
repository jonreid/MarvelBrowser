//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOCharacterResponseModel;


@interface QCOCharacterSliceResponseModel : NSObject

@property (nonatomic, assign, readonly) NSInteger offset;
@property (nonatomic, assign, readonly) NSInteger total;
@property (nonatomic, copy, readonly) NSArray<QCOCharacterResponseModel *> *characters;

- (instancetype)initWithOffset:(NSInteger)offset total:(NSInteger)total;

@end
