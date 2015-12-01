//
//  CustomListViewController.h
//  HotelApp
//
//  Created by Theodore Abshire on 11/30/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSArray* (^fetchDataBlock)();
typedef void (^setupCellBlock)(UITableViewCell*, NSObject*);
typedef void (^selectCellBlock)(NSObject*);

@interface CustomListViewController : UIViewController

@property (strong, nonatomic) NSArray *data;

-(void) setUpWithColor:(UIColor *)backColor;

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, copy) fetchDataBlock fetchData;
@property (nonatomic, copy) setupCellBlock setupCell;
@property (nonatomic, copy) selectCellBlock selectCell;

@end
