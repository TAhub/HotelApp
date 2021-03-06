//
//  Reservation.h
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room, Guest;

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (void) makeReservationForRoom:(Room *)room startTime:(NSDate *)startTime endTime:(NSDate *)endTime guestName:(NSString *)guestName guestAge:(int) guestAge;

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
