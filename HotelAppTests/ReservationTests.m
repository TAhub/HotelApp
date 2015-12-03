//
//  ReservationTests.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/2/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Reservation.h"
#import "CoreDataStack.h"
#import "Room.h"
#import "Hotel.h"

@interface ReservationTests : XCTestCase

@property (strong, nonatomic) Room *roomToCheck;

@end

@implementation ReservationTests

- (void)setUp {
	[super setUp];
	
	//add a sample hotel
	Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];
	hotel.name = @"Hotel";
	hotel.location = @"Place";
	hotel.stars = @(5);
	
	//add a sample room
	self.roomToCheck = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];
	self.roomToCheck.name = @"Room";
	self.roomToCheck.beds = @(2);
	self.roomToCheck.cost = @(100);
	self.roomToCheck.hotel = hotel;
	
	//save the data
	NSError *saveError;
	BOOL isSaved = [[CoreDataStack sharedStack].managedObjectContext save:&saveError];
	if (isSaved)
		NSLog(@"Saved default data.");
	else
		NSLog(@"Failed to save default data.");
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testExample {
	// This is an example of a functional test case.
	// Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testReservationAddWorks
{
	//add a reservation
	[Reservation makeReservationForRoom:self.roomToCheck startTime:[NSDate date] endTime:[NSDate date] guestName:@"Person"];
	
	//how many reservations are there?
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
	NSError *error;
	NSInteger count = [[CoreDataStack sharedStack].managedObjectContext countForFetchRequest:request error:&error];
	XCTAssertTrue(count > 0);
}

- (void)testPerformanceExample {
	// This is an example of a performance test case.
	[self measureBlock:^{
		// Put the code you want to measure the time of here.
	}];
}

@end
