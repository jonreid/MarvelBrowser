//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOURLQueryMatcher.h"


@interface QCOURLQueryMatcher ()
@property (nonatomic, copy, readonly) NSString *name;
@end

@implementation QCOURLQueryMatcher

- (instancetype)initWithName:(NSString *)name valueMatcher:(id)valueMatcher
{
    self = [super init];
    if (self)
    {
        _name = [name copy];
    }
    return self;
}

- (BOOL)matches:(id)item
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:item
                                                resolvingAgainstBaseURL:NO];
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;
    NSURLQueryItem *queryItem = queryItems.firstObject;
    return [queryItem.name isEqualToString:self.name];
}

- (void)describeTo:(id <HCDescription>)description
{
}

@end


id hasQuery(NSString *name, id valueMatcher)
{
    return [[QCOURLQueryMatcher alloc] initWithName:name valueMatcher:valueMatcher];
}
