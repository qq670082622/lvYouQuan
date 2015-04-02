//
//  OrderTmpView.h
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/27.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define gap 10

@class OrderModel;

@protocol OrderCellDelegate <NSObject>

- (void)checkDetailAtIndex:(NSInteger)index;

@end

@interface OrderTmpView : UIView

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) OrderModel *model;

@property (nonatomic,weak) id<OrderCellDelegate> orderDelegate;

@end
