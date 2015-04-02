//
//  MeHeader.m
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/31.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "MeHeader.h"

@implementation MeHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *headIcon = [[UIButton alloc] init];
        headIcon.layer.cornerRadius = 50;
        headIcon.layer.masksToBounds = YES;
        [headIcon setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
        [headIcon addTarget:self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headIcon];
        self.headIcon = headIcon;
        
        UILabel *nickName = [[UILabel alloc] init];
        nickName.text = @"hehehe";
        nickName.textAlignment = NSTextAlignmentCenter;
        nickName.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:nickName];
        self.nickName = nickName;
        
        UILabel *personType = [[UILabel alloc] init];
        personType.text = @"lalala";
        personType.textColor = [UIColor whiteColor];
        personType.textAlignment = NSTextAlignmentCenter;
        personType.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        personType.layer.cornerRadius = 5;
        personType.layer.masksToBounds = YES;
        personType.font = [UIFont systemFontOfSize:13];
        [self addSubview:personType];
        self.personType = personType;
        
        UIButton *setBtn = [[UIButton alloc] init];
        [setBtn setImage:[UIImage imageNamed:@"setting_icon"] forState:UIControlStateNormal];
        setBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 5, 0);
        [setBtn addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:setBtn];
        self.setBtn = setBtn;
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wobg"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat headW = 100;
    CGFloat headX = (self.frame.size.width - 100) * 0.5;
    self.headIcon.frame = CGRectMake(headX, 20, headW, headW);
    
    CGFloat nameY = CGRectGetMaxY(self.headIcon.frame) + 8;
    self.nickName.frame = CGRectMake(headX, nameY, headW, 20);
    
    CGFloat typeY = CGRectGetMaxY(self.nickName.frame) + 8;
    self.personType.frame = CGRectMake(headX, typeY, headW, 20);
    
    CGFloat btnX = self.frame.size.width - 48;
    self.setBtn.frame = CGRectMake(btnX, 8, 40, 40);
}

- (void)setting:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickSetting)]) {
        [_delegate didClickSetting];
    }
}

- (void)clickHead:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickHeadIcon)]) {
        [_delegate didClickHeadIcon];
    }
}

@end
