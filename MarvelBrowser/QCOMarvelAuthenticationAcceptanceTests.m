//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOMarvelAuthenticationAcceptanceTests : XCTestCase
@end

@implementation QCOMarvelAuthenticationAcceptanceTests

- (void)testValidCallToMarvel_ShouldGetHTTPStatusCode200
{
    NSString *validQueryMissingAuthentication = @"http://gateway.marvel.com/v1/public/characters?nameStartsWith=Spider";
    NSURL *validQueryURL = [NSURL URLWithString:
            [validQueryMissingAuthentication stringByAppendingString:[QCOMarvelAuthentication URLParameters]]];

    __block NSHTTPURLResponse *httpResponse;
    [self startGETRequestToURL:validQueryURL
         withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             httpResponse = (NSHTTPURLResponse *)response;
         }];

    assertWithTimeout(5, thatEventually(@(httpResponse.statusCode)), is(@200));
}

- (void)startGETRequestToURL:(NSURL *)url
       withCompletionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:completionHandler];
    [dataTask resume];
}

@end
