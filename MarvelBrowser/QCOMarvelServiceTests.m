//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelService.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOMarvelServiceTests : XCTestCase
@end

@implementation QCOMarvelServiceTests

- (void)testSessionConfiguration_ShouldBeNSURLSessionConfiguration
{
    QCOMarvelService *sut = [[QCOMarvelService alloc] init];

    NSURLSessionConfiguration *sessionConfiguration = sut.sessionConfiguration;

    assertThat(sessionConfiguration, isA([NSURLSessionConfiguration class]));
}

@end
