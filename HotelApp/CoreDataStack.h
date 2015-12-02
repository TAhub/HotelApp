//
//  CoreDataStack.h
//  HotelApp
//
//  Created by Theodore Abshire on 12/2/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CoreDataStack: NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end