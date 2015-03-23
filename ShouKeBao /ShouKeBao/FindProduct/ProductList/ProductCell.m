//
//  ProductCell.m
//  ShouKeBao
//
//  Created by David on 15/3/17.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{ static NSString *cellID = @"productCell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:nil options:nil] lastObject];
        
        
        
    }
    return cell;
}

-(void)setModal:(ProductModal *)modal
{
    _modal = modal;
    self.icon.image = [UIImage imageNamed:modal.icon];
    self.descript.text = modal.descript;
    self.productNum.text = modal.productNum;
    self.normalPrice.text = [NSString stringWithFormat:@"￥%@",modal.normalPrice];
    self.cheapPrice.text = [NSString stringWithFormat:@"￥%@",modal.cheapPrice];
    self.profits.text = [NSString stringWithFormat:@"￥%@",modal.profits];
    
    
   
}



@end
