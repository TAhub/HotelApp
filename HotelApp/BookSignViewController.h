//
//  BookSignViewController.h
//  HotelApp
//
//  Created by Theodore Abshire on 12/1/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface BookSignViewController : UIViewController

@property (weak, nonatomic) Room *room;
@property (weak, nonatomic) NSDate *startDate;
@property (weak, nonatomic) NSDate *endDate;

@end
