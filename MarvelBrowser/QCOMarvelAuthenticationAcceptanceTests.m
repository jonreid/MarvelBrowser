//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelAuthentication.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOMarvelAuthenticationAcceptanceTests : XCTestCase
@end

@implementation QCOMarvelAuthenticationAcceptanceTests

- (void)testValidCallToMarvel_ShouldGetHTTPStatusCode200
{
    NSString *validQueryMissingAuthentication = @"https://gateway.marvel.com/v1/public/characters?nameStartsWith=Spider";
    NSURL *validQueryURL = [NSURL URLWithString:
            [validQueryMissingAuthentication stringByAppendingString:[QCOMarvelAuthentication URLParameters]]];

    __block BOOL completionHandlerInvoked;
    __block NSHTTPURLResponse *httpResponse;
    __block NSError *responseError;
    [self startGETRequestToURL:validQueryURL
         withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             httpResponse = (NSHTTPURLResponse *)response;
             responseError = error;
             completionHandlerInvoked = YES;
         }];
    assertWithTimeout(5, thatEventually(@(completionHandlerInvoked)), is(@YES));

    assertThat(responseError, is(nilValue()));
    assertThat(@(httpResponse.statusCode), is(@200));
}

- (void)startGETRequestToURL:(NSURL *)url
       withCompletionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:completionHandler];
    [dataTask resume];
}

@end
