//
//  BindPhoneViewController.m
//  ShouKeBao
//
//  Created by Chard on 15/3/23.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "WriteFileManager.h"

@interface BindPhoneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;// 手机号

@property (weak, nonatomic) IBOutlet UITextField *code;// 验证码

@property (weak, nonatomic) IBOutlet UITextField *passWord;// 密码

@property (weak, nonatomic) IBOutlet UITextField *confirm;// 确认密码

@end

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机";
    
    UIView *gap = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.tableView.tableHeaderView = gap;
    // Do any additional setup after loading the view.
}

#pragma mark - private
/**
 *  获取验证码
 */
- (IBAction)getCode:(id)sender
{
    NSLog(@"----");
}

/**
 *  绑定账号
 */
- (IBAction)bindAccount:(id)sender
{
    NSLog(@"00000");
}


@end
