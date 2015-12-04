//
//  HotelTests.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/3/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Hotel.h"
#import "CoreDataStack.h"

@interface HotelTests : XCTestCase

@property (strong, nonatomic) Hotel *hotelToCheck;

@end

@implementation HotelTests

- (void)setUp {
    [super setUp];
	
	//add a sample hotel
	self.hotelToCheck = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:[CoreDataStack sharedStack].managedObjectContext];
	self.hotelToCheck.name = @"Hotel";
	self.hotelToCheck.location = @"Place";
	self.hotelToCheck.stars = @(5);
	
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

- (void)testGetHotels
{
	NSArray *hotels = [Hotel getHotels];
	XCTAssertTrue(hotels.count > 0);
}

@end
