//
//  OrderTmpView.m
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/27.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "OrderTmpView.h"
#import "OrderModel.h"
#import "LinkButton.h"
#import "UIImageView+WebCache.h"
#import "ButtonList.h"
#import "NSString+QD.h"

@interface OrderTmpView()

// 上线条
@property (weak, nonatomic) IBOutlet UIView *sep1;
// 订单号
@property (weak, nonatomic) IBOutlet UILabel *tourCode;
// 状态图标
@property (weak, nonatomic) IBOutlet UIImageView *statusIcon;
// 创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTime;
// 旅游图标
@property (weak, nonatomic) IBOutlet UIImageView *tourIcon;
// 旅游标题
@property (weak, nonatomic) IBOutlet UILabel *tourTitle;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *price;
// 成人个数
@property (weak, nonatomic) IBOutlet UILabel *adultCount;
// 儿童个数
@property (weak, nonatomic) IBOutlet UILabel *childCount;
// 出发日期
@property (weak, nonatomic) IBOutlet UILabel *goTime;
// 状态描述
@property (weak, nonatomic) IBOutlet UILabel *statusDes;

// 底部按钮
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic,strong) NSMutableArray *buttonArr;

@end

@implementation OrderTmpView

#pragma mark - setter
- (void)setModel:(OrderModel *)model
{
    _model = model;
    
    // 上线条
    self.sep1.backgroundColor = model.TopBarColor;
    // 订单号
    self.tourCode.text = model.Code;
    // 状态图标
    self.statusIcon.backgroundColor = model.TopBarColor;
    // 创建时间
    self.createTime.text = model.CreatedDate;
    // 旅游图标
    [self.tourIcon sd_setImageWithURL:[NSURL URLWithString:model.ProductPicUrl] placeholderImage:nil];
    // 旅游标题
    self.tourTitle.text = model.ProductName;
    // 价格
    NSString *tmp = [NSString stringWithFormat:@"￥%@(同行)",model.OrderPrice];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:tmp];
    [attrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],
                             NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} range:NSMakeRange(0, model.OrderPrice.length + 1)];
    [self.price setAttributedText:attrStr];
    
    if ([model.IsCruiseShip integerValue] == 1) {
        self.adultCount.hidden = YES;
        NSString *count = [NSString stringWithFormat:@"%ld",[model.PersonCount integerValue] + [model.ChildCount integerValue]];
        self.childCount.text = [NSString stringWithFormat:@"人数%@",count];
    }else{
        self.adultCount.hidden = NO;
        // 成人个数
        self.adultCount.text = [NSString stringWithFormat:@"成人%@",model.PersonCount];
        // 儿童个数
        self.childCount.text = [NSString stringWithFormat:@"儿童%@",model.ChildCount];
    }
    
    // 出发日期
    self.goTime.text = model.GoDate;
    // 状态描述
    self.statusDes.text = model.StateText;
    
    self.statusDes.textColor = model.StateTextColor;
    
    // 先清空再添加
    [self.buttonArr removeAllObjects];
    for (UIView *view in self.bottomView.subviews) {
        [view removeFromSuperview];
    }
    
    for (ButtonList *btn in model.buttonList) {
        LinkButton *b = [[LinkButton alloc] init];
        b.titleLabel.font = [UIFont systemFontOfSize:14];
        [b setTitle:btn.text forState:UIControlStateNormal];
        [b setTitleColor:btn.color forState:UIControlStateNormal];
        b.layer.borderWidth = 1;
        b.layer.cornerRadius = 3;
        b.layer.borderColor = btn.color.CGColor;
        b.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        b.linkUrl = btn.linkurl;
        b.text = btn.text;
        [b addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:b];
        [self.buttonArr addObject:b];
    }
    
    [self layoutButtons];
}

#pragma mark - getter
- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

#pragma mark - private
- (void)layoutButtons
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGSize max = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGFloat btnW = 0;
    
    for (int i = 0; i < self.buttonArr.count; i ++) {
        
        LinkButton *btn = self.buttonArr[i];
        CGSize btnSize = [NSString textSizeWithText:btn.text font:[UIFont systemFontOfSize:14] maxSize:max];
        btnW += btnSize.width + 12 + gap;
        CGFloat btnX = screenW - btnW;
        btn.frame = CGRectMake(btnX, 5, btnSize.width + 12, btnSize.height + 12);
    }
}

- (void)clickButton:(LinkButton *)sender
{
    if (sender.linkUrl.length) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"orderCellDidClickButton" object:nil userInfo:@{@"linkUrl":sender.linkUrl}];
    }else{
        if (_orderDelegate && [_orderDelegate respondsToSelector:@selector(checkDetailAtIndex:)]) {
            [_orderDelegate checkDetailAtIndex:self.indexPath.row];
        }
    }
}


@end
