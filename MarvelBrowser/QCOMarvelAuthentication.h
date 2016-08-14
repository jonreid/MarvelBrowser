//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@interface QCOMarvelAuthentication : NSObject

+ (NSString *)URLParameters;

@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *privateKey;
@property (nonatomic, copy) NSString *(^calculateMD5)(NSString *);

- (NSString *)URLParameters;
- (NSString *)URLParametersWithTimestamp:(NSString *)timestamp;

@end
