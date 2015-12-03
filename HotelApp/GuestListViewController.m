//
//  GuestListViewController.m
//  HotelApp
//
//  Created by Theodore Abshire on 12/2/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "GuestListViewController.h"
#import "Constants.h"
#import "Guest.h"
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"

@interface GuestListViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSFetchedResultsController *frc;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation GuestListViewController

#pragma mark - setup

-(void)loadView
{
	[super loadView];
	
	//add a background color
	self.view.backgroundColor = [UIColor whiteColor];
	
	//make the contents
	UITableView *table = [UITableView new];
	UIButton *backButton = [UIButton new];
	UITextField *field = [UITextField new];
	
	//configure the parts
	[self configureButton:backButton title:@"Back"];
	[table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[table setTranslatesAutoresizingMaskIntoConstraints:NO];
	field.placeholder = @"Guest Name Search String";
	field.translatesAutoresizingMaskIntoConstraints = false;
	
	//add the views
	[self.view addSubview:table];
	[self.view addSubview:backButton];
	[self.view addSubview:field];
	
	//add constraints
	NSDictionary *views = NSDictionaryOfVariableBindings(field, table, backButton);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[backButton]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[field]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[table]-|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[field][table][backButton]-|" options:0 metrics:nil views:views]];
	
	//add button targets
	[backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
	
	//setup table
	table.delegate = self;
	table.dataSource = self;
	self.tableView = table;
	
	//setup field
	field.delegate = self;
	[field addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
	
	
	//make the fetched results controller
	NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
	NSSortDescriptor *alphaSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	req.sortDescriptors = [NSArray arrayWithObject:alphaSort];
	self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:req managedObjectContext:[CoreDataStack sharedStack].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	self.frc.delegate = self;
	
	NSError *fetchError;
	[self.frc performFetch:&fetchError];
}

-(void)configureButton:(UIButton *)button title:(NSString *)title
{
	[button setTitle:title forState:UIControlStateNormal];
	[button setBackgroundColor:LOOKUP_COLOR];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button layer].cornerRadius = CORNER_RADIUS;
	[button setTranslatesAutoresizingMaskIntoConstraints:NO];
}

#pragma mark - selectors

-(void) textFieldChanged:(UITextField *)sender
{
	//change the predicate
	self.frc.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name == %@", sender.text];
	
	//fetch again
	NSError *fetchError;
	[self.frc performFetch:&fetchError];
	[self.tableView reloadData];
}
										 
-(void) backButton:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - text field delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return true;
}

#pragma mark - NSFetchedResultsController stuff

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[self.frc sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	if ([[self.frc sections] count] > 0) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [[self.frc sections] objectAtIndex:section];
		return [sectionInfo numberOfObjects];
	} else
		return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	
	
	NSManagedObject *managedObject = [self.frc objectAtIndexPath:indexPath];
	Guest *guest = (Guest *)managedObject;
	
	cell.textLabel.text = guest.name;
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[self.frc sections] count] > 0) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [[self.frc sections] objectAtIndex:section];
		return [sectionInfo name];
	} else
		return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return [self.frc sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return [self.frc sectionForSectionIndexTitle:title atIndex:index];
}

@end