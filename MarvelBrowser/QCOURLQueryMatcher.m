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
    {
        [self reportNonURL:item toDescription:mismatchDescription];
        return NO;
    }

    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:item
                                                resolvingAgainstBaseURL:NO];
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;
    for (NSURLQueryItem *queryItem in queryItems)
    {
        if ([queryItem.name isEqualToString:self.name])
        {
            NSString *value = [queryItem.value stringByAddingPercentEncodingWithAllowedCharacters:
                    [NSCharacterSet URLQueryAllowedCharacterSet]];
            if ([self.valueMatcher matches:value])
                return YES;
            [self reportQuery:urlComponents.query
                  actualValue:value
                toDescription:mismatchDescription];
            return NO;
        }
    }

    if (!urlComponents.query)
        [self reportNoQueryInURL:item toDescription:mismatchDescription];
    else
        [self reportNameNotFoundInQuery:urlComponents.query toDescription:mismatchDescription];
    return NO;
}

- (void)reportNonURL:(id)item toDescription:(id <HCDescription>)mismatchDescription
{
    [[mismatchDescription
            appendText:@"was "]
            appendDescriptionOf:item];
}

- (void)reportQuery:(NSString *)query
        actualValue:(NSString *)value
      toDescription:(id <HCDescription>)mismatchDescription
{
    [[[[[mismatchDescription
            appendDescriptionOf:self.name]
            appendText:@" had value "]
            appendDescriptionOf:value]
            appendText:@" in "]
            appendText:query];
}

- (void)reportNoQueryInURL:(id)URL
             toDescription:(id <HCDescription>)mismatchDescription
{
    [[mismatchDescription
            appendText:@"no query in "]
            appendDescriptionOf:URL];
}

- (void)reportNameNotFoundInQuery:(NSString *)query
                    toDescription:(id <HCDescription>)mismatchDescription
{
    [[[[mismatchDescription
            appendText:@"no "]
            appendDescriptionOf:self.name]
            appendText:@" name in "]
            appendText:query];
}

- (void)describeTo:(id <HCDescription>)description
{
    [[[[description
            appendText:@"URL with "]
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
