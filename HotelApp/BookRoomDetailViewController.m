//
//  BookRoomDetailViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/1/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "BookRoomDetailViewController.h"
#import "Room.h"
#import "Reservation.h"
#import "Constants.h"
#import "BookSignViewController.h"

@interface BookRoomDetailViewController ()

@property (weak, nonatomic) UIDatePicker *startTime;
@property (weak, nonatomic) UIDatePicker *endTime;

@end

@implementation BookRoomDetailViewController

#pragma mark - setup

-(void)loadView
{
	[super loadView];
	
	//set the view background color
	self.view.backgroundColor = [UIColor whiteColor];
	
	//make the contents
	UIDatePicker *start = [UIDatePicker new];
	UILabel *startLabel = [UILabel new];
	UIDatePicker *end = [UIDatePicker new];
	UILabel *endLabel = [UILabel new];
	UIButton *backButton = [UIButton new];
	UIButton *bookButton = [UIButton new];
	UIButton *availButton = [UIButton new];
	UIView *spacer = [UIView new];
	
	//configure the contents
	NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
	[self configureButton:backButton title:TEXT_BACK];
	[self configureButton:bookButton title:TEXT_BOOK];
	[self configureButton:availButton title:TEXT_FIRSTOPENING];
	[start setDate:startOfToday];
	[start setDatePickerMode:UIDatePickerModeDate];
	[start setMinimumDate:startOfToday];
	[start setTranslatesAutoresizingMaskIntoConstraints:NO];
	startLabel.text = TEXT_STARTTIME;
	startLabel.textAlignment = NSTextAlignmentCenter;
	startLabel.translatesAutoresizingMaskIntoConstraints = false;
	[end setDate:startOfToday];
	[end setDatePickerMode:UIDatePickerModeDate];
	[end setMinimumDate:startOfToday];
	[end setTranslatesAutoresizingMaskIntoConstraints:NO];
	endLabel.text = TEXT_ENDTIME;
	endLabel.textAlignment = NSTextAlignmentCenter;
	endLabel.translatesAutoresizingMaskIntoConstraints = false;
	[spacer setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	//add the views
	[self.view addSubview:start];
	[self.view addSubview:startLabel];
	[self.view addSubview:end];
	[self.view addSubview:endLabel];
	[self.view addSubview:backButton];
	[self.view addSubview:spacer];
	[self.view addSubview:bookButton];
	[self.view addSubview:availButton];
	
	//add constraints
	NSDictionary *views = NSDictionaryOfVariableBindings(start, startLabel, end, endLabel, backButton, spacer, bookButton, availButton);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[startLabel]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[endLabel]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[start]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[end]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[startLabel][start][endLabel][end][bookButton][spacer][backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[startLabel][start][endLabel][end][availButton][spacer][backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[startLabel(==endLabel)]" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[bookButton(==availButton)]" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[bookButton][availButton]-|" options:0 metrics:nil views:views]];
	
	
	//set up the date pickers
	self.startTime = start;
	self.endTime = end;
	[start addTarget:self action:@selector(startSet) forControlEvents:UIControlEventValueChanged];
	[end addTarget:self action:@selector(endSet) forControlEvents:UIControlEventValueChanged];
	
	//add button targets
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	[bookButton addTarget:self action:@selector(bookButton:) forControlEvents:UIControlEventTouchUpInside];
	[availButton addTarget:self action:@selector(availButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)configureButton:(UIButton *)button title:(NSString *)title
{
	[button setTitle:title forState:UIControlStateNormal];
	[button setBackgroundColor:BOOK_COLOR];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button layer].cornerRadius = CORNER_RADIUS;
	[button setTranslatesAutoresizingMaskIntoConstraints:NO];
}

#pragma mark - selectors

-(void) startSet
{
	if ([self.endTime.date compare:self.startTime.date] == NSOrderedAscending)
	{
		//don't let the user stay backwards in time
		[self.startTime setDate:self.endTime.date];
	}
}

-(void) endSet
{
	if ([self.endTime.date compare:self.startTime.date] == NSOrderedAscending)
	{
		//don't let the user stay backwards in time
		[self.endTime setDate:self.startTime.date];
	}
}

-(void) bookButton:(UIButton *)sender
{
	//check availability
	Reservation *res = [Room intersection:self.room startTime:self.startTime.date endTime:self.endTime.date];
	if (res == nil)
	{
		BookSignViewController *vc = [BookSignViewController new];
		vc.room = self.room;
		vc.startDate = self.startTime.date;
		vc.endDate = self.endTime.date;
		
		[self.navigationController pushViewController:vc animated:YES];
	}
	else
	{
		//you were blocked by a reservation
		NSDateFormatter *format = [NSDateFormatter new];
		format.dateFormat = @"dd MMM, YYYY";
		[self warning:TEXT_NOTAVAILABLE body:[NSString stringWithFormat:TEXT_NOTAVAILABLELONG, [format stringFromDate:res.startTime], [format stringFromDate:res.endTime]]];
	}
}

-(void) availButton:(UIButton *)sender
{
	//check every day inside the date range
	NSDate *dateOn = [self.startTime.date copy];
	NSDate *startDate = nil;
	NSDate *endDate = nil;
	
	while ([dateOn compare:self.endTime.date] != NSOrderedDescending)
	{
		if ([Room intersection:self.room startTime:dateOn endTime:dateOn] == nil)
		{
			if (startDate == nil)
			{
				startDate = dateOn;
				endDate = dateOn;
			}
			else
				endDate = dateOn;
		}
		else if (startDate != nil)
		{
			//leave early
			break;
		}
		
		//advance to the next day
		dateOn = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:1 toDate:dateOn options:0];
	}
	
	if (startDate != nil)
	{
		//you found a range!
		[self.startTime setDate:startDate];
		[self.endTime setDate:endDate];
	}
	else
	{
		//there were no openings in that range
		[self warning:TEXT_NOOPENINGS body:TEXT_NOOPENINGSLONG];
	}
}

-(void) backButton:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - helpers

-(void) warning:(NSString *)message body:(NSString *)body
{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:body preferredStyle:UIAlertControllerStyleAlert];
	alert.view.backgroundColor = BOOK_COLOR;
	UIAlertAction *okay = [UIAlertAction actionWithTitle:TEXT_SORRY style:UIAlertActionStyleCancel handler:nil];
	[alert addAction:okay];
	[self presentViewController:alert animated:YES completion:nil];
}

@end
