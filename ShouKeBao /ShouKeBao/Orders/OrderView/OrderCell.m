//
//  OrderCell.m
//  ShouKeBao
//
//  Created by Chard on 15/3/24.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "OrderCell.h"
#import "OrderModel.h"
#import "UIImageView+WebCache.h"
#import "ButtonList.h"
#import "LinkButton.h"
#import "OrderTmpView.h"

@interface OrderCell()

@end

@implementation OrderCell

#pragma mark - initailize
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ordercellaa";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.orderTmpView];
    }
    return self;
}

- (OrderTmpView *)orderTmpView
{
    if (!_orderTmpView) {
        _orderTmpView = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:nil options:nil] lastObject];
        _orderTmpView.frame = self.bounds;
    }
    return _orderTmpView;
}

- (void)setModel:(OrderModel *)model
{
    _model = model;
    
    self.orderTmpView.model = model;
}

@end
