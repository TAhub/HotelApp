//
//  Room+CoreDataProperties.h
//  HotelApp
//
//  Created by Theodore Abshire on 12/1/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Room.h"

NS_ASSUME_NONNULL_BEGIN

@interface Room (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *beds;
@property (nullable, nonatomic, retain) NSNumber *cost;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Hotel *hotel;
@property (nullable, nonatomic, retain) NSSet<Reservation *> *reservations;

@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet<Reservation *> *)values;
- (void)removeReservations:(NSSet<Reservation *> *)values;

@end

NS_ASSUME_NONNULL_END
