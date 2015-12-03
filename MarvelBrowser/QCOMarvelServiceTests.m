//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <XCTest/XCTest.h>


@interface QCOMarvelServiceTests : XCTestCase
@end

@implementation QCOMarvelServiceTests

- (void)testSessionConfiguration_ShouldBeNSURLSessionConfiguration
{
    [[QCOMarvelService alloc] init];
}

@end
