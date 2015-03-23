//
//  ChildAccountViewController.m
//  ShouKeBao
//
//  Created by Chard on 15/3/23.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "ChildAccountViewController.h"
#import "BindPhoneViewController.h"

@interface ChildAccountViewController ()

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ChildAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择账号";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self loadDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - private
- (void)loadDataSource
{
    self.dataSource = @[@"aaa",@"bbb",@"ccc",@"ddd"].mutableCopy;
}

#pragma mark - getter
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"childaccountcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-dianpu"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"iconfont-wo"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Auth" bundle:nil];
        BindPhoneViewController *bind = [sb instantiateViewControllerWithIdentifier:@"BindPhone"];
        [self.navigationController pushViewController:bind animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
