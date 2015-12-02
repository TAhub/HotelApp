//
//  Hotel.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "Hotel.h"
#import "Room.h"
#import "AppDelegate.h"

@implementation Hotel

+ (NSArray *) getHotels
{
	//retrieve data from coredata
	AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
	NSManagedObjectContext *context = delegate.stack.managedObjectContext;
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
