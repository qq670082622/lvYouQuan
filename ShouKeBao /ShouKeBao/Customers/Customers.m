//
//  Customers.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "Customers.h"
#import "CustomCell.h"
#import "CustomModel.h"
#import "CustomerDetailViewController.h"
#import "addCustomerViewController.h"
#import "BatchAddViewController.h"
@interface Customers ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArr;
- (IBAction)addNewUser:(id)sender;
- (IBAction)importUser:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *subView;

@end

@implementation Customers

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"管客户";
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.rowHeight = 55;
    [self loadDataSource];
    [self customerRightBarItem];
}

-(void)customerRightBarItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
    [button setImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(setUp)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem= barItem;
}


-(void)setUp
{
    if (self.subView.hidden == YES) {
        self.subView.hidden = NO;
    }else if (self.subView.hidden == NO){
        self.subView.hidden = YES;
    }
}

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (IBAction)addNewUser:(id)sender {
    self.subView.hidden = YES;
    addCustomerViewController *add = [[addCustomerViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
    
}

- (IBAction)importUser:(id)sender {
    self.subView.hidden = YES;
    BatchAddViewController *batch = [[BatchAddViewController alloc] init];
    [self.navigationController pushViewController:batch animated:YES];
}

-(void)loadDataSource
{
    for (int i = 1; i<11 ; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"屌丝%d号",i] forKey:@"userName"];
        [dic setObject:[NSString stringWithFormat:@"1312055575%d",i] forKey:@"userTele"];
        [dic setObject:[NSString stringWithFormat:@"20%d",i] forKey:@"userOrder"];
        [self.dataArr addObject:dic];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CustomerDetailViewController *detail = [[CustomerDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [CustomCell cellWithTableView:tableView];
    cell.model = _dataArr[indexPath.row];
    return cell;
    }


- (IBAction)timeOrderAction:(id)sender {
    
}
- (IBAction)orderNumAction:(id)sender {
    
}
- (IBAction)wordOrderAction:(id)sender {
    
}

- (IBAction)customSearch:(id)sender {
    
}
@end
