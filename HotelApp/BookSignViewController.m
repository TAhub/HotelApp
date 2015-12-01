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
	
	//configure the contents
	[self configureButton:backButton title:@"Back" color:BOOK_COLOR];
	[self configureButton:commitButton title:@"DO IT" color:BOOK_COLOR];
	label.text = [NSString stringWithFormat:@"Book room for $%i?", self.price];
	label.textAlignment = NSTextAlignmentCenter;
	label.translatesAutoresizingMaskIntoConstraints = false;
	[spacer setTranslatesAutoresizingMaskIntoConstraints:NO];
	field.placeholder = @"Your name here";
	field.translatesAutoresizingMaskIntoConstraints = false;
	
	//add the views
	[self.view addSubview:backButton];
	[self.view addSubview:commitButton];
	[self.view addSubview:label];
	[self.view addSubview:spacer];
	[self.view addSubview:field];
	
	//add constraints
	NSDictionary *views = NSDictionaryOfVariableBindings(backButton, commitButton, label, spacer, field);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[commitButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[label]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[field]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[label][field][commitButton][spacer][backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commitButton(==backButton)]" options:0 metrics:nil views:views]];
	
	//add button targets
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	[commitButton addTarget:self action:@selector(commitButton:) forControlEvents:UIControlEventTouchUpInside];
	
	//set up the field
	self.field = field;
	field.delegate = self;
}

-(void)configureButton:(UIButton *)button title:(NSString *)title color:(UIColor *)color;
{
	[button setTitle:title forState:UIControlStateNormal];
	[button setBackgroundColor:color];
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
	if (self.field.text != nil && self.field.text.length > 0)
	{
		//add it
		AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
		NSManagedObjectContext *context = delegate.managedObjectContext;
		Reservation *res = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:context];
		Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
		
		res.guest = guest;
		res.startTime = self.startDate;
		res.endTime = self.endDate;
		guest.name = self.field.text;
		self.room.reservations = [self.room.reservations setByAddingObject:res];
		
		NSError *saveError;
		
		BOOL isSaved = [context save:&saveError];
		if (isSaved)
			NSLog(@"Saved reservation.");
		else
			NSLog(@"Failed to save reservation.");
		
		//and pop way back
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}

@end
