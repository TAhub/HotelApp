//
//  Reservation.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/2/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface Reservation : XCTestCase

@property (strong, nonatomic) stack

@end

@implementation Reservation

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)reservationAddWorks
{
	
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
