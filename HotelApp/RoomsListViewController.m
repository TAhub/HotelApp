//
//  RoomsListViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "RoomsListViewController.h"
#import "AppDelegate.h"
#import "Room.h"

@interface RoomsListViewController ()

@end

@implementation RoomsListViewController

- (void)loadView
{
	[super loadView];
	
	self.fetchData = ^NSArray*(void)
	{
		//retrieve data from coredata
		AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
		NSManagedObjectContext *context = delegate.managedObjectContext;
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
		
		NSError *fetchError;
		NSArray *d = [context executeFetchRequest:request error:&fetchError];
		if (fetchError)
		{
			NSLog(@"Error fetching hotel data!");
		}
		
		return d;
	};
	
	
	
	self.setupCell = ^void(UITableViewCell* cell, NSObject *object)
	{
		Hotel *hotel = (Hotel *)object;
		cell.textLabel.text = hotel.name;
	};
	
	[self setUpWithColor:BROWSE_COLOR];
}

@end
