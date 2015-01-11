//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt

#import "ViewController.h"

#import "MarvelKeys.m"
#import <CommonCrypto/CommonDigest.h>

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

    // Create MD5 hash:
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(keysString, strlen(keysString), digest);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSUInteger i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hash appendFormat:@"%02x", digest[i]];

    // Manually confirm that it's 32 hex digits:
    NSLog(@"%@", hash);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
