//
//  HotelListViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "HotelListViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "Hotel.h"

@interface HotelListViewController ()

@end

@implementation HotelListViewController

- (void)loadView
{
	[super loadView];
	
	self.fetchData = ^NSArray*(void)
	{
		return [Hotel getHotels];
	};
	
	__weak typeof(self) weakSelf = self;
	self.selectCell = ^void(NSObject *object)
	{
		Hotel *hotel = (Hotel *)object;
		CustomListViewControllerWithHotel *vc = [weakSelf.nextVC new];
		vc.hotel = hotel;
		
		[weakSelf.navigationController pushViewController:vc animated:YES];
	};
	
	self.setupCell = ^void(UITableViewCell* cell, NSObject *object)
	{
		Hotel *hotel = (Hotel *)object;
		cell.textLabel.text = hotel.name;
	};
	
	[self setUpWithColor:self.color];
}

@end
