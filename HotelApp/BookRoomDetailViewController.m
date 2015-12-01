//
//  BookRoomDetailViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/1/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "BookRoomDetailViewController.h"
#import "Constants.h"

@interface BookRoomDetailViewController ()

@property (weak, nonatomic) UIDatePicker *startTime;
@property (weak, nonatomic) UIDatePicker *endTime;

@end

@implementation BookRoomDetailViewController

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
	UIView *spacer = [UIView new];
	
	//configure the contents
	[backButton setTitle:@"Back" forState:UIControlStateNormal];
	[backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
	[backButton setBackgroundColor:BOOK_COLOR];
	[backButton layer].cornerRadius = CORNER_RADIUS;
	[backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[start setDate:[NSDate date]];
	[start setDatePickerMode:UIDatePickerModeDate];
	[start setMinimumDate:[NSDate date]];
	[start setTranslatesAutoresizingMaskIntoConstraints:NO];
	startLabel.text = @"Start time";
	startLabel.textAlignment = NSTextAlignmentCenter;
	startLabel.translatesAutoresizingMaskIntoConstraints = false;
	[end setDate:[NSDate date]];
	[end setDatePickerMode:UIDatePickerModeDate];
	[end setMinimumDate:[NSDate date]];
	[end setTranslatesAutoresizingMaskIntoConstraints:NO];
	endLabel.text = @"End time";
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
	
	//add constraints
	NSDictionary *views = NSDictionaryOfVariableBindings(start, startLabel, end, endLabel, backButton, spacer);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[startLabel]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[endLabel]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[start]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[end]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[startLabel][start][endLabel][end][spacer][backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[startLabel(==endLabel)]" options:0 metrics:nil views:views]];
	
	//set up the date pickers
	self.startTime = start;
	self.endTime = end;
	
	//add button targets
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) backButton:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
