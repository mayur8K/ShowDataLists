//
//  ShowDataListsTests.m
//  ShowDataListsTests
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataManager.h"

@interface ShowDataListsTests : XCTestCase
{
    DataManager *managerObj;
    XCTestExpectation *expectation;
}
@end

@implementation ShowDataListsTests

- (void)setUp {
    [super setUp];
    managerObj = [[DataManager alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDataObjects:)
                                                 name:@"LOADLIST_NOTIFICATION"
                                               object:nil];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LOADLIST_NOTIFICATION" object:nil];

}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

// written a self driven test to check if server returns the data or not.
- (void)testGetServerData
{
    [managerObj getServerData];
  expectation = [self expectationWithDescription:@"Query timed out."];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"Failure");
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

//MARK:- Notification Handlers
- (void)receiveDataObjects:(NSNotification *)notification
{
    NSMutableDictionary *dict = (NSMutableDictionary *)notification.object;
    if(dict.count > 0)
    {
        [expectation fulfill];
    }
}
@end
