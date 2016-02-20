//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOURLQueryMatcher.h"

#import <OCHamcrest/HCRequireNonNilObject.h>
#import <OCHamcrest/HCWrapInMatcher.h>


@interface QCOURLQueryMatcher ()
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) id <HCMatcher> valueMatcher;
@end

@implementation QCOURLQueryMatcher

- (instancetype)initWithName:(NSString *)name valueMatcher:(id <HCMatcher>)valueMatcher
{
    self = [super init];
    if (self)
    {
        _name = [name copy];
        _valueMatcher = valueMatcher;
    }
    return self;
}

- (BOOL)matches:(id)item describingMismatchTo:(id <HCDescription>)mismatchDescription
{
    if (![item isKindOfClass:[NSURL class]])
        return NO;

    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:item
                                                resolvingAgainstBaseURL:NO];
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;
    for (NSURLQueryItem *queryItem in queryItems)
        if ([queryItem.name isEqualToString:self.name])
            return [self.valueMatcher matches:queryItem.value];

    [[[[mismatchDescription
            appendText:@"no "]
            appendDescriptionOf:self.name]
            appendText:@" name in "]
            appendText:urlComponents.query];
    return NO;
}

- (void)describeTo:(id <HCDescription>)description
{
    [[[[description
            appendText:@"a URL with "]
            appendDescriptionOf:self.name]
            appendText:@" = "]
            appendDescriptionOf:self.valueMatcher];
}

@end


id hasQuery(NSString *name, id valueMatcher)
{
    HCRequireNonNilObject(name);
    HCRequireNonNilObject(valueMatcher);
    return [[QCOURLQueryMatcher alloc] initWithName:name valueMatcher:HCWrapInMatcher(valueMatcher)];
}
