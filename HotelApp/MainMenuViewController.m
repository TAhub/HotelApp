//
//  MainMenuViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "MainMenuViewController.h"

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
	[self configureButton:browse title:@"Browse" color:[UIColor colorWithRed:1.0 green:1.0 blue:0.8 alpha:1.0]];
	[self configureButton:book title:@"Book" color:[UIColor colorWithRed:1.0 green:0.8 blue:1.0 alpha:1.0]];
	[self configureButton:lookup title:@"Look Up" color:[UIColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0]];
	
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
}

-(void)configureButton:(UIButton *)button title:(NSString *)title color:(UIColor *)color;
{
	[button setTitle:title forState:UIControlStateNormal];
	[button setBackgroundColor:color];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button layer].cornerRadius = 15;
	[button setTranslatesAutoresizingMaskIntoConstraints:NO];
}

@end
