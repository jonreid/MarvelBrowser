//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "ViewController.h"

#import "QCOFetchCharactersMarvelService.h"
#import "QCOMarvelAuthentication.h"
#import "QCOFetchCharactersRequestModel.h"


@interface ViewController ()
@property (nonatomic, strong) QCOFetchCharactersMarvelService *service;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.service = [[QCOFetchCharactersMarvelService alloc] initWithSession:[NSURLSession sharedSession] authParametersGenerator:^NSString * {
        return [QCOMarvelAuthentication URLParameters];
    }];
    QCOFetchCharactersRequestModel *requestModel = [[QCOFetchCharactersRequestModel alloc] initWithNamePrefix:@"Spider" pageSize:1 offset:0];
    [self.service fetchCharactersWithRequestModel:requestModel];
}
@end
