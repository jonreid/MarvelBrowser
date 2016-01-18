//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersMarvelService.h"
#import "QCOFetchCharactersRequestModel.h"


@interface QCOFetchCharactersMarvelService ()
@property (nonatomic, strong, readonly) NSURLSession *session;
@end

@implementation QCOFetchCharactersMarvelService

- (instancetype)initWithSession:(NSURLSession *)session
{
    self = [super init];
    if (self)
        _session = session;
    return self;
}

- (void)fetchCharacters:(QCOFetchCharactersRequestModel *)requestModel
{
    NSURL *url = [[NSURL alloc] initWithString:@"foo://bar"];
    [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    }];
}

@end
