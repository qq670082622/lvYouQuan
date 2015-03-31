//
//  addRemondViewController.m
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/31.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "addRemondViewController.h"

@interface addRemondViewController ()
@property (weak, nonatomic) IBOutlet UITextView *descript;
- (IBAction)setTime:(id)sender;
- (IBAction)Save:(id)sender;

@end

@implementation addRemondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)setTime:(id)sender {
}

- (IBAction)Save:(id)sender {
}
@end
