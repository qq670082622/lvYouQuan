//
//  orderCell.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "orderCell.h"

@implementation orderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1) {
        if ([self.delegate respondsToSelector:@selector(urgedDidClicked:)]) {
            [self.delegate urgedBtnDidClicked:self];
        
        }}
    if (btn.tag ==2) {
        if ([self.delegate respondsToSelector:@selector(fillDidClicked:)]) {
            [self.delegate fillBtnDidClicked:self];

    }}
}
@end
