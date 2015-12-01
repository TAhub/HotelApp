//
//  RoomsListViewController.h
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "CustomListViewController.h"
#import "Hotel.h"

@interface RoomsListViewController : CustomListViewController

@property (weak, nonatomic) Hotel *hotel;

@end
