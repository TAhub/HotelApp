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

@property (strong, nonatomic) Hotel *hotelToCheck;
@property (strong, nonatomic) Room *roomToCheck;

@end

@implementation ReservationTests

- (void)setUp {
	[super setUp];
	 
	//add a sample hotel
	self.hotelToCheck = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];
	self.hotelToCheck.name = @"Hotel";
	self.hotelToCheck.location = @"Place";
	self.hotelToCheck.stars = @(5);
	
	//add a sample room
	self.roomToCheck = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];
	self.roomToCheck.name = @"Room";
	self.roomToCheck.beds = @(2);
	self.roomToCheck.cost = @(100);
	self.roomToCheck.hotel = self.hotelToCheck;
	
	//save the data
	NSError *saveError;
	BOOL isSaved = [[CoreDataStack sharedStack].managedObjectContext save:&saveError];
	if (isSaved)
		NSLog(@"Saved test data.");
	else
		NSLog(@"Failed to save test data.");
}

- (void)tearDown {

	NSManagedObjectContext *context = [CoreDataStack sharedStack].managedObjectContext;
	[context deleteObject:self.hotelToCheck];

	//save the lack-of-data
	NSError *saveError;
	BOOL isSaved = [[CoreDataStack sharedStack].managedObjectContext save:&saveError];
	if (isSaved)
		NSLog(@"Saved lack-of-data.");
	else
		NSLog(@"Failed to save lack-of-data.");
	
	
	[super tearDown];
}

- (void)testReservationAddWorks
{
	//add a reservation
	[Reservation makeReservationForRoom:self.roomToCheck startTime:[NSDate date] endTime:[NSDate date] guestName:@"Person" guestAge: 12];
	
	//how many reservations are there?
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
	NSError *error;
	NSInteger count = [[CoreDataStack sharedStack].managedObjectContext countForFetchRequest:request error:&error];
	XCTAssertTrue(count > 0);
}

@end
