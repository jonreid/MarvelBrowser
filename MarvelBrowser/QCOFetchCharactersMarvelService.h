//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOFetchCharactersRequestModel;


@interface QCOFetchCharactersMarvelService : NSObject

@property (nonatomic, strong, readonly) NSURLSessionDataTask *dataTask;

- (instancetype)initWithSession:(NSURLSession *)session
        authParametersGenerator:(NSString *(^)())authParametersGenerator;
- (void)fetchCharactersWithRequestModel:(QCOFetchCharactersRequestModel *)requestModel;

@end
