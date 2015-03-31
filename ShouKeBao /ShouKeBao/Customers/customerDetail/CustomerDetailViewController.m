//
//  CustomerDetailViewController.m
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/30.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "CustomerDetailViewController.h"
#import "EditCustomerDetailViewController.h"
#import "CustomerOrdersUIViewController.h"
#import "remondViewController.h"
@interface CustomerDetailViewController ()
@property (nonatomic,weak) UISegmentedControl *segmentControl;
@end

@implementation CustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customerRightBarItem];
    self.title = @"客户详情";
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 28)];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"客户资料",@"订单详情",nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    [segment addTarget:self action:@selector(sex:)forControlEvents:UIControlEventValueChanged];
    [segment setTintColor:[UIColor whiteColor]];
    segment.frame = CGRectMake(0, 0, 220, 28);
    [segment setSelected:YES];
    [segment setSelectedSegmentIndex:0];
    [titleView addSubview:segment];
    self.segmentControl = segment;
    self.navigationItem.titleView = titleView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.segmentControl setSelectedSegmentIndex:0];
}
-(void)sex:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    if (control.selectedSegmentIndex == 1) {
        CustomerOrdersUIViewController *orders = [[CustomerOrdersUIViewController alloc] init];
        [self.navigationController pushViewController:orders animated:YES];
    }
}
-(void)customerRightBarItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
    [button setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(EditCustomerDetail)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem= barItem;
}
-(void)EditCustomerDetail
{
    EditCustomerDetailViewController *edit = [[EditCustomerDetailViewController alloc] init];
    
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)remond:(id)sender {
    remondViewController *remond = [[remondViewController alloc] init];
    [self.navigationController pushViewController:remond animated:YES];
}

- (IBAction)deleteCustomer:(id)sender {
    
}
@end
