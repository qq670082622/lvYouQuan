//
//  CantactView.m
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/27.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "CantactView.h"

@interface CantactView()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *mobile;

@property (weak, nonatomic) IBOutlet UIButton *qqNum;

@end

@implementation CantactView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CantactView" owner:nil options:nil] lastObject];
    }
    return self;
}

@end
