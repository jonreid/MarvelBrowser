//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface QCOFetchCharactersResponseModel : NSObject

@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, assign, readonly) NSInteger offset;

- (instancetype)initWithCode:(NSInteger)code status:(NSString *)status offset:(NSInteger)offset;

@end
