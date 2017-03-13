//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


@interface QCOFetchCharactersResponseCharacterBuilder : NSObject

@property (nonatomic, copy) NSString *name;

- (void)parseDictionary:(NSDictionary *)dict;

@end
