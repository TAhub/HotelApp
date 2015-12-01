//
//  BookRoomViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/1/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "BookRoomViewController.h"
#import "Constants.h"
#import "Room.h"
#import "BookRoomDetailViewController.h"

@implementation BookRoomViewController

- (void)loadView
{
	[super loadView];
	
	NSArray *rooms = [self.hotel.rooms allObjects];
	self.fetchData = ^NSArray*(void)
	{
		return rooms;
	};
	
	__weak typeof(self) weakSelf = self;
	self.selectCell = ^void(NSObject *object)
	{
		Room *room = (Room *)object;
		BookRoomDetailViewController *vc = [BookRoomDetailViewController new];
		vc.room = room;
		
		[weakSelf.navigationController pushViewController:vc animated:YES];
	};
	
	self.setupCell = ^void(UITableViewCell* cell, NSObject *object)
	{
		Room *room = (Room *)object;
		cell.textLabel.text = room.name;
	};
	
	[self setUpWithColor:BOOK_COLOR];
}

@end