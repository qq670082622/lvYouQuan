//
//  orderCell.h
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oderMoal.h"
@class oderMoal;
@protocol cellBtnDelegate <NSObject>
@optional
- (void)urgedBtnDidClicked:(UIButton *)urgedBtn;
- (void)fillBtnDidClicked:(UIButton *)fillBtn;
@end

@interface orderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UILabel *orderDate;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *orderDescript;
@property (weak, nonatomic) IBOutlet UILabel *orderSetUpTimeAndPerson;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic ,  strong) oderMoal *modal;
@property (nonatomic, weak) id<cellBtnDelegate> delegate;

-(IBAction)btnClick:(id)sender;
@end
