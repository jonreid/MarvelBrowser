//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"


static void ApplicationDidFinishLaunching(id self, SEL _cmd)
{
    NSLog(@"TestingAppDelegate finished launching!");
}

static UIWindow *window()
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectZero];
    window.rootViewController = [[UIViewController alloc] init];
    return window;
}

static Class createTestingAppDelegate()
{
    Class class = objc_allocateClassPair([NSObject class], "TestingAppDelegate", 0);
    
    class_addMethod(class, @selector(applicationDidFinishLaunching:), (IMP)ApplicationDidFinishLaunching, NULL);
    
    class_addMethod(class, @selector(window), (IMP)window, "@@:");
    
    objc_registerClassPair(class);
    
    return class;
}


int main(int argc, char *argv[])
{
    @autoreleasepool {
        BOOL isTesting = NSClassFromString(@"XCTestCase") != nil;
        
        Class appDelegateClass = (isTesting) ? createTestingAppDelegate() : [AppDelegate class];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
    }
}
