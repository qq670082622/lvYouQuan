//
//  OrderCell.h
//  ShouKeBao
//
//  Created by Chard on 15/3/24.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderModel;

@interface OrderCell : UITableViewCell

@property (nonatomic,strong) OrderModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
