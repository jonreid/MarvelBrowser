//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@interface QCOMarvelAuthentication : NSObject

@property (nonatomic, copy, readonly) NSString *timestamp;

- (NSString *)publicKey;
- (NSString *)privateKey;

@end
