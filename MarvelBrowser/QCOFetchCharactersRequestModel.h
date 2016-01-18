//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface QCOFetchCharactersRequestModel : NSObject

@property (nonatomic, copy, readonly) NSString *namePrefix;
@property (nonatomic, assign, readonly) NSUInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger offset;

- (instancetype)initWithNamePrefix:(NSString *)namePrefix
                          pageSize:(NSUInteger)pageSize
                            offset:(NSUInteger)offset;

@end
