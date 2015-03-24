//
//  ProductCell.h
//  ShouKeBao
//
//  Created by David on 15/3/17.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModal.h"
#import "JASwipeCell.h"

#define gap 10

@class ProductModal;
@interface ProductCell : JASwipeCell




@property (strong, nonatomic) ProductModal *modal;
+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
