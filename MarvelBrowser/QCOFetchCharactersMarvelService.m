//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersMarvelService.h"

#import "QCOFetchCharactersRequestModel.h"


@interface QCOFetchCharactersMarvelService ()
@property (nonatomic, strong, readonly) NSURLSession *session;
@property (nonatomic, copy) NSString *(^authParametersGenerator)();
@end

@implementation QCOFetchCharactersMarvelService

- (instancetype)initWithSession:(NSURLSession *)session
        authParametersGenerator:(NSString *(^)())authParametersGenerator
{
    self = [super init];
    if (self) {
        _session = session;
        _authParametersGenerator = [authParametersGenerator copy];
    }
    return self;
}

- (void)fetchCharactersWithRequestModel:(QCOFetchCharactersRequestModel *)requestModel
{
    NSString *encodedNamePrefix = [requestModel.namePrefix stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:
            @"https://gateway.marvel.com/v1/public/characters?nameStartsWith=%@&limit=%lu&offset=%lu",
            encodedNamePrefix,
            (unsigned long)requestModel.pageSize,
            (unsigned long)requestModel.offset
    ];
    urlString = [urlString stringByAppendingString:self.authParametersGenerator()];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    }];
    [task resume];
}

@end
