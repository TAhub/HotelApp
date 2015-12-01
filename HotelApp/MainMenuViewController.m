//
//  MainMenuViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "MainMenuViewController.h"
#import "HotelListViewController.h"
#import "RoomsListViewController.h"
#import "Constants.h"
#import "BookRoomViewController.h"

@interface MainMenuViewController ()

-(void)configureButton:(UIButton *)button title:(NSString *)title color:(UIColor *)color;

@end

@implementation MainMenuViewController

- (void)loadView
{
	[super loadView];
	
	//load up the buttons
	UIButton *browse = [UIButton new];
	UIButton *book = [UIButton new];
	UIButton *lookup = [UIButton new];
	
	//configure the buttons
	[self configureButton:browse title:@"Browse" color:BROWSE_COLOR];
	[self configureButton:book title:@"Book" color:BOOK_COLOR];
	[self configureButton:lookup title:@"Look Up" color:LOOKUP_COLOR];
	
	//add views
	[self.view addSubview:browse];
	[self.view addSubview:book];
	[self.view addSubview:lookup];
	
	//add constraints
	NSDictionary *buttons = NSDictionaryOfVariableBindings(browse, book, lookup);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[browse]-|" options:0 metrics:nil views:buttons]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[book]-|" options:0 metrics:nil views:buttons]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[lookup]-|" options:0 metrics:nil views:buttons]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[browse][book][lookup]-|" options:0 metrics:nil views:buttons]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[browse(==book)]" options:0 metrics:nil views:buttons]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[browse(==lookup)]" options:0 metrics:nil views:buttons]];
	
	//add button targets
	[browse addTarget:self action:@selector(browseButton:) forControlEvents:UIControlEventTouchUpInside];
	[book addTarget:self action:@selector(bookButton:) forControlEvents:UIControlEventTouchUpInside];
	[lookup addTarget:self action:@selector(lookupButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)browseButton:(UIButton *)sender
{
	HotelListViewController *hlvc = [HotelListViewController new];
	hlvc.color = BROWSE_COLOR;
	hlvc.nextVC = [RoomsListViewController class];
	[self.navigationController pushViewController:hlvc animated:YES];
}

-(void)bookButton:(UIButton *)sender
{
	HotelListViewController *hlvc = [HotelListViewController new];
	hlvc.color = BOOK_COLOR;
	hlvc.nextVC = [BookRoomViewController class];
	[self.navigationController pushViewController:hlvc animated:YES];
}

-(void)lookupButton:(UIButton *)sender
{
	
}

-(void)configureButton:(UIButton *)button title:(NSString *)title color:(UIColor *)color;
{
	[button setTitle:title forState:UIControlStateNormal];
	[button setBackgroundColor:color];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button layer].cornerRadius = CORNER_RADIUS;
	[button setTranslatesAutoresizingMaskIntoConstraints:NO];
}

@end
