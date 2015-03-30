//
//  CustomCell.m
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/30.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "CustomCell.h"
#import "UIImageView+WebCache.h"
@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{ static NSString *cellID = @"customCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //        [cell.contentView addSubview:self.btn1];
        
    }
    return cell;
}
-(void)setModal:(CustomModel *)modal
{
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:modal.userIcon] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    self.userName.text = modal.userName;
    self.userTele.text = [NSString stringWithFormat:@"电话：%@",modal.userTele];
    self.userOders.text = [NSString stringWithFormat:@"订单数：%@",modal.userOrder];
}

@end
