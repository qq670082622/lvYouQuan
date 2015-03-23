//
//  ProductCell.h
//  ShouKeBao
//
//  Created by David on 15/3/17.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModal.h"
@class ProductModal;
@interface ProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descript;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *productNum;
@property (weak, nonatomic) IBOutlet UILabel *normalPrice;
@property (weak, nonatomic) IBOutlet UILabel *cheapPrice;
@property (weak, nonatomic) IBOutlet UILabel *profits;

@property (weak, nonatomic) IBOutlet UIImageView *jiafanImage;
@property (weak, nonatomic) IBOutlet UILabel *jiafanValue;
@property (weak, nonatomic) IBOutlet UIImageView *quanImage;
@property (weak, nonatomic) IBOutlet UILabel *quanValue;
@property (weak, nonatomic) IBOutlet UIImageView *ShanDian;
@property (weak, nonatomic) IBOutlet UILabel *setUpPlace;



@property (strong, nonatomic) ProductModal *modal;
+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
