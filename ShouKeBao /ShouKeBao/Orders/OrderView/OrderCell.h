//
//  OrderCell.h
//  ShouKeBao
//
//  Created by Chard on 15/3/24.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@class OrderModel;
@class OrderCell;
@class OrderTmpView;


@interface OrderCell : MGSwipeTableCell

@property (nonatomic,strong) OrderModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) OrderTmpView *orderTmpView;

@end
