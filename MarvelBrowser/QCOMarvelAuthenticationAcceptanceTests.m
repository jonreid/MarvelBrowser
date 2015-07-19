//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface QCOMarvelAuthenticationAcceptanceTests : XCTestCase
@end

@implementation QCOMarvelAuthenticationAcceptanceTests

- (void)testValidCallToMarvel_ShouldGetHTTPStatusCode200
{
    NSString *validQueryMissingAuthentication = @"http://gateway.marvel.com/v1/public/characters?nameStartsWith=Spider";
    QCOMarvelAuthentication *authentication = [[QCOMarvelAuthentication alloc] init];
    NSURL *validQueryURL = [NSURL URLWithString:
            [validQueryMissingAuthentication stringByAppendingString:[authentication URLParameters]]];

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    __block NSHTTPURLResponse *httpResponse;
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:validQueryURL
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                httpResponse = (NSHTTPURLResponse *)response;
                                            }];
    [dataTask resume];

    assertThatAfter(5, futureValueOf(@(httpResponse.statusCode)), is(@200));
}

@end
