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
#import "Constants.h"

@interface RoomsListViewController ()

@end

@implementation RoomsListViewController

- (void)loadView
{
	[super loadView];
	
	NSArray *rooms = [self.hotel.rooms allObjects];
	self.fetchData = ^NSArray*(void)
	{
		return rooms;
	};
	
	self.selectCell = ^void(NSObject *object)
	{
		//TODO: do something
	};
	
	self.setupCell = ^void(UITableViewCell* cell, NSObject *object)
	{
		Room *room = (Room *)object;
		cell.textLabel.text = room.name;
	};
	
	[self setUpWithColor:BROWSE_COLOR];
}

@end
