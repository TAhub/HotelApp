//
//  CustomListViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "CustomListViewController.h"
#import "Constants.h"

@interface CustomListViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CustomListViewController

- (NSArray *) data
{
	if (!_data)
	{
		_data = self.fetchData();
	}
	
	return _data;
}

-(void) setUpWithColor:(UIColor *)backColor
{
	//set the view background color
	self.view.backgroundColor = [UIColor whiteColor];
	
	//make the contents
	UITableView *table = [UITableView new];
	UIButton *backButton = [UIButton new];
	
	//configure the parts
	[backButton setTitle:@"Back" forState:UIControlStateNormal];
	[backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
	[backButton setBackgroundColor:backColor];
	[backButton layer].cornerRadius = CORNER_RADIUS;
	[backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[table setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	//add the views
	[self.view addSubview:table];
	[self.view addSubview:backButton];
	
	//add constraints
	NSDictionary *buttons = NSDictionaryOfVariableBindings(table, backButton);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[backButton]-|" options:0 metrics:nil views:buttons]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[table]-|" options:0 metrics:nil views:buttons]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[table][backButton]-|" options:0 metrics:nil views:buttons]];
	
	//add button targets
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	
	//setup table
	table.delegate = self;
	table.dataSource = self;
	self.tableView = table;
}

-(void) backButton:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - table view data source
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	
	self.setupCell(cell, self.data[indexPath.row]);
	
	return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.data count];
}

#pragma mark - table view delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.selectCell(self.data[indexPath.row]);
}

@end