//
//  BookSignViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/1/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "BookSignViewController.h"
#import "Constants.h"
#import "Reservation.h"
#import "AppDelegate.h"
#import "Guest.h"

@interface BookSignViewController () <UITextFieldDelegate>

@property int price;
@property (weak, nonatomic) UITextField *field;
@property (weak, nonatomic) UITextField *ageField;

@end

@implementation BookSignViewController

#pragma mark - setup

-(void)loadView
{
	[super loadView];
	
	//generate the price
	NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self.startDate toDate:self.endDate options:0];
	self.price = (int) (self.room.cost.integerValue * (comp.day + 1));
	
	//set the view background color
	self.view.backgroundColor = [UIColor whiteColor];
	
	//make the contents
	UIButton *backButton = [UIButton new];
	UIButton *commitButton = [UIButton new];
	UILabel *label = [UILabel new];
	UIView *spacer = [UIView new];
	UITextField *field = [UITextField new];
	UITextField *ageField = [UITextField new];
	
	//configure the contents
	[self configureButton:backButton title:TEXT_BACK];
	[self configureButton:commitButton title:TEXT_DOIT];
	label.text = [NSString stringWithFormat:TEXT_BOOKQUESTION, self.price];
	label.textAlignment = NSTextAlignmentCenter;
	label.translatesAutoresizingMaskIntoConstraints = false;
	[spacer setTranslatesAutoresizingMaskIntoConstraints:NO];
	field.placeholder = TEXT_YOURNAMEHERE;
	field.translatesAutoresizingMaskIntoConstraints = false;
	[ageField setPlaceholder:TEXT_YOURAGEHERE];
	[ageField setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	//add the views
	[self.view addSubview:backButton];
	[self.view addSubview:commitButton];
	[self.view addSubview:label];
	[self.view addSubview:spacer];
	[self.view addSubview:field];
	[self.view addSubview:ageField];
	
	//add constraints
	NSDictionary *views = NSDictionaryOfVariableBindings(backButton, commitButton, label, spacer, field, ageField);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[ageField]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[commitButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[label]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[field]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[label]-[field]-[ageField]-[commitButton][spacer][backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commitButton(==backButton)]" options:0 metrics:nil views:views]];
	
	//add button targets
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	[commitButton addTarget:self action:@selector(commitButton:) forControlEvents:UIControlEventTouchUpInside];
	
	//set up the field
	self.field = field;
	self.ageField = ageField;
	field.delegate = self;
	ageField.delegate = self;
}

-(void)configureButton:(UIButton *)button title:(NSString *)title
{
	[button setTitle:title forState:UIControlStateNormal];
	[button setBackgroundColor:BOOK_COLOR];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button layer].cornerRadius = CORNER_RADIUS;
	[button setTranslatesAutoresizingMaskIntoConstraints:NO];
}

#pragma mark - text field delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return true;
}

#pragma mark - selectors

-(void) backButton:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void) commitButton:(UIButton *)sender
{
	if (self.field.text != nil && self.field.text.length > 0 && self.ageField.text != nil && self.ageField.text.length > 0 && self.ageField.text.intValue > 0)
	{
		//make the reservation
		[Reservation makeReservationForRoom:self.room startTime:self.startDate endTime:self.endDate guestName:self.field.text guestAge:self.ageField.text.intValue];
		
		//and pop way back
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}

@end
