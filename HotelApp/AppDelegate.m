//
//  AppDelegate.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"
#import "Hotel.h"
#import "Room.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize stack = _stack;
-(CoreDataStack *)stack
{
	// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
	if (_stack != nil) {
		return _stack;
	}
	_stack = [CoreDataStack new];
	return _stack;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	[self initialDatabaseConfig];
	
	//set up the window
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	
	//make a root view controller
	MainMenuViewController *root = [MainMenuViewController new];
	
	//make the navigation controller
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
	nav.navigationBarHidden = true;
	self.window.rootViewController = nav;
	
	return YES;
}

- (void)initialDatabaseConfig
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
	
	NSError *error;
	NSInteger count = [self.stack.managedObjectContext countForFetchRequest:request error:&error];
	
	if (count == 0)
	{
		//load up the data plist
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Hotels" ofType:@"plist"];
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
		
		for (id name in dict)
		{
			Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.stack.managedObjectContext];
			NSDictionary *hotelDict = dict[name];
			
			hotel.name = name;
			hotel.location = hotelDict[@"location"];
			hotel.stars = hotelDict[@"stars"];
			
			NSArray *rooms = hotelDict[@"rooms"];
			for (int i = 0; i < rooms.count; i++)
			{
				Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.stack.managedObjectContext];
				NSDictionary *roomDict = rooms[i];
				
				room.name = roomDict[@"name"];
				room.hotel = hotel;
				room.beds = roomDict[@"beds"];
				room.cost = roomDict[@"cost"];
			}
		}
		
		
		//save the data
		NSError *saveError;
		BOOL isSaved = [self.stack.managedObjectContext save:&saveError];
		if (isSaved)
			NSLog(@"Saved default data.");
		else
			NSLog(@"Failed to save default data.");
	}
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	// Saves changes in the application's managed object context before the application terminates.
//	[self saveContext];
	[self.stack saveContext];
}
@end
