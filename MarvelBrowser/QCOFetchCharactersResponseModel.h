//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface QCOFetchCharactersResponseModel : NSObject

@property (nonatomic, assign, readonly) NSInteger code;

- (instancetype)initWithCode:(NSInteger)code;

@end
