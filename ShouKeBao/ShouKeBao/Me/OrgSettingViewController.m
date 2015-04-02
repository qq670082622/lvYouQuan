//
//  OrgSettingViewController.m
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/31.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "OrgSettingViewController.h"

@interface OrgSettingViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *comanyName;

@property (weak, nonatomic) IBOutlet UITextField *place;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UITextField *banName;

@property (weak, nonatomic) IBOutlet UITextField *touchMan;

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *qq;

@property (weak, nonatomic) IBOutlet UITextField *wechat;

@property (weak, nonatomic) IBOutlet UITextView *remark;

@end

@implementation OrgSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 2) {
        NSLog(@"----");
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
