//
//  Guest+CoreDataProperties.h
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Guest.h"

NS_ASSUME_NONNULL_BEGIN

@interface Guest (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Reservation *> *reservations;

@end

@interface Guest (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet<Reservation *> *)values;
- (void)removeReservations:(NSSet<Reservation *> *)values;

@end

NS_ASSUME_NONNULL_END
