//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOMarvelService.h"

#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import <XCTest/XCTest.h>


@interface QCOMarvelServiceTests : XCTestCase
@end

@implementation QCOMarvelServiceTests

- (void)testFoo_ShouldBar
{
    NSURLSession *mockSession = mock([NSURLSession class]);
}

@end
