//
//  Login.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "Login.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "Register.h"
@interface Login ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
- (IBAction)forgetBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)registerBtnAction:(id)sender;




@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 9;
    self.loginBtn.layer.masksToBounds = YES;
    
    self.forgetBtn.layer.cornerRadius = 6;
    self.forgetBtn.layer.borderWidth = 1;
    self.forgetBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.forgetBtn.layer.masksToBounds = YES;
    
    self.registerBtn.layer.cornerRadius = 6;
    self.registerBtn.layer.borderWidth = 1;
    self.registerBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.registerBtn.layer.masksToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)loginAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)forgetBtnAction:(id)sender {
}
- (IBAction)registerBtnAction:(id)sender {
    [self.navigationController pushViewController:[[Register alloc] init] animated:YES];
}


@end
