#import "QCOParseFetchCharactersJSONData.h"

#import "QCOFetchCharactersResponseModel.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface QCOParseFetchCharactersResponseTests : XCTestCase
@end

@implementation QCOParseFetchCharactersResponseTests

- (NSData *)sampleResponse
{
    NSString *json =
                    @"{"
                    "  \"code\": 200,"
                    "  \"status\": \"Ok\","
                    "  \"data\": {"
                    "    \"offset\": 1,"
                    "    \"total\": 3,"
                    "    \"results\": ["
                    "      {"
                    "        \"name\": \"NAME1\""
                    "      },"
                    "      {"
                    "        \"name\": \"NAME2\""
                    "      }"
                    "    ]"
                    "  }"
                    "}";
    return [json dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)testParseSampleResponse_ShouldHaveCode200
{
    QCOFetchCharactersResponseModel *response = QCOParseFetchCharactersJSONData([self sampleResponse]);
    
    assertThat(@(response.code), is(@200));
}

//- (void)testParseSampleResponse_ShouldHaveStatusOk
//{
//    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
//
//    assertThat(response.status, is(@"Ok"));
//}
//
//- (void)testParseSampleResponse_ShouldHaveOffset1
//{
//    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
//
//    assertThat(@(response.offset), is(@1));
//}
//
//- (void)testParseSampleResponse_ShouldHaveTotal3
//{
//    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
//
//    assertThat(@(response.total), is(@3));
//}
//
//- (void)testParseSampleResponse_ShouldHaveTwoCharacters
//{
//    QCOFetchCharactersResponseModel *response = [self buildSampleResponse];
//
//    assertThat(response.characters, containsIn(@[
//            hasProperty(@"name", @"NAME1"),
//            hasProperty(@"name", @"NAME2")]));
//}

@end
