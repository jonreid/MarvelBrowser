//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TestingAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        BOOL isRunningTests = NSClassFromString(@"XCTestCase") != nil;
        Class appDelegateClass = isRunningTests ? [TestingAppDelegate class] : [AppDelegate class];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
    }
}
