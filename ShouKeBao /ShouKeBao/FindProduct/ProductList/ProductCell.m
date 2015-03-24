//
//  ProductCell.m
//  ShouKeBao
//
//  Created by David on 15/3/17.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "ProductCell.h"
#import "UIImageView+WebCache.h"
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
//    @property (weak, nonatomic) IBOutlet UIImageView *jiafanImage;
//    @property (weak, nonatomic) IBOutlet UILabel *jiafanValue;
//    @property (weak, nonatomic) IBOutlet UIImageView *quanImage;
//    @property (weak, nonatomic) IBOutlet UILabel *quanValue;
//    @property (weak, nonatomic) IBOutlet UIImageView *ShanDian;
//    @property (weak, nonatomic) IBOutlet UILabel *setUpPlace;
//    
    _modal = modal;
   // self.icon.image = [UIImage imageNamed:modal.PicUrl];
    [self.icon sd_setImageWithURL:[[NSURL alloc] initWithString:modal.PicUrl]];
    self.descript.text = modal.Name;
    self.productNum.text = modal.Code;
    self.normalPrice.text = [NSString stringWithFormat:@"%@",modal.PersonPrice];
    self.cheapPrice.text = [NSString stringWithFormat:@"%@",modal.PersonPeerPrice];
    self.profits.text = [NSString stringWithFormat:@"%@",modal.PersonProfit];
    self.jiafanValue.text = [NSString stringWithFormat:@"%@",modal.PersonBackPrice];
    self.quanValue.text = [NSString stringWithFormat:@"%@",modal.PersonCashCoupon];
    self.setUpPlace.text = modal.StartCityName;
    
    
//    @property (nonatomic, copy) NSString *ID;//产品ID(用于收藏)
//    @property (nonatomic, copy) NSString *PicUrl;//
//    @property (nonatomic, copy) NSString *Name;//产品介绍
//    @property (nonatomic, copy) NSString *Code;//产品编号
//    @property (nonatomic, copy) NSString *PersonPrice;//门市价
//    @property (nonatomic, copy) NSString *PersonPeerPrice;//同行价
//    @property (nonatomic, copy) NSString *PersonProfit;//利润
//    @property (nonatomic, copy) NSString *PersonBackPrice;//加返
//    @property (nonatomic, copy) NSString *PersonCashCoupon;//券
//    @property (nonatomic, copy) NSString *StartCityName;//出发城市名称
//    @property (assign , nonatomic) BOOL *IsComfirmStockNow;//是否闪电发班
//    @property (assign , nonatomic) NSNumber *StartCity;//出发城市编号
//    @property (copy,nonatomic) NSString *LastScheduleDate;//最近班期
//    @property (copy,nonatomic) NSString *SupplierName;//供应商
//    @property (assign , nonatomic) BOOL *IsFavorites;//是否收藏
//    @property (copy,nonatomic) NSString *ContactName;//联系人名称
//    @property (copy,nonatomic) NSString *ContactMobile;//联系人电话
   
}



@end
