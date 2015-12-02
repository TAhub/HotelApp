//
//  Reservation.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "Reservation.h"
#import "Room.h"
#import "CoreDataStack.h"
#import "Guest.h"

@implementation Reservation

+ (void) makeReservationForRoom:(Room *)room startTime:(NSDate *)startTime endTime:(NSDate *)endTime guestName:(NSString *)guestName
{
	//sanity check
	if ([Room intersection:room startTime:startTime endTime:endTime] != nil)
	{
		return;
	}
	
	//add it
	NSManagedObjectContext *context = [CoreDataStack sharedStack].managedObjectContext;
	Reservation *res = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
	Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
	
	res.guest = guest;
	res.startTime = startTime;
	res.endTime = endTime;
	guest.name = guestName;
	room.reservations = [room.reservations setByAddingObject:res];
	
	NSError *saveError;
	
	BOOL isSaved = [context save:&saveError];
	if (isSaved)
		NSLog(@"Saved reservation.");
	else
		NSLog(@"Failed to save reservation.");
}

@end
