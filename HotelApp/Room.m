//
//  Room.m
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "Room.h"
#import "Hotel.h"
#import "Reservation.h"

@implementation Room

// Insert code here to add functionality to your managed object subclass

+ (Reservation *) intersection:(Room *)room startTime:(NSDate *)startTime endTime:(NSDate *)endTime
{
	for (Reservation *res in room.reservations)
	{
		if ([Room date:startTime isBetweenDate:res.startTime andDate:res.endTime] ||
			[Room date:endTime isBetweenDate:res.startTime andDate:res.endTime])
		{
			return res;
		}
	}
	return nil;
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
	//thanks to
	//http://stackoverflow.com/questions/1072848/how-to-check-if-an-nsdate-occurs-between-two-other-nsdates
	//because I got really confused using the array-sort compare to figure out if one date was before another
	//which is, uh, not what it's supposed to do
	//but that seems to be the only easy way to compare...
	
	if ([date compare:beginDate] == NSOrderedAscending)
		return NO;
	
	if ([date compare:endDate] == NSOrderedDescending)
		return NO;
	
	return YES;
}

@end
