//
//  Hotel.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "Hotel.h"
#import "Room.h"
#import "CoreDataStack.h"

@implementation Hotel

+ (NSArray *) getHotels
{
	//retrieve data from coredata
	NSManagedObjectContext *context = [CoreDataStack sharedStack].managedObjectContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
	
	NSError *fetchError;
	NSArray *d = [context executeFetchRequest:request error:&fetchError];
	if (fetchError)
	{
		NSLog(@"Error fetching hotel data!");
	}
	
	return d;
}

@end
