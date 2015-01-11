//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt

#import "ViewController.h"

#import "MarvelKeys.m"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Concatenate keys per https://developer.marvel.com/documentation/authorization
    NSString *timeStamp = @"1"; // Hard-coded for spike
    NSString *keys = [NSString stringWithFormat:@"%@%@%@", timeStamp, MarvelPrivateKey, MarvelPublicKey];
    char const *keysString = [keys UTF8String];

    // Confirm manually:
    NSLog(@"%s", keysString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
