//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class QCOFetchCharactersRequestModel;
@class QCONetworkRequest;


@interface QCOFetchCharactersMarvelService : NSObject

- (instancetype)initWithSession:(NSURLSession *)session
        authParametersGenerator:(NSString *(^)(void))authParametersGenerator;
- (void)fetchCharactersWithRequestModel:(QCOFetchCharactersRequestModel *)requestModel
                         networkRequest:(QCONetworkRequest *)networkRequest;

@end
