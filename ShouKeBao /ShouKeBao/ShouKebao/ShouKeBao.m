//
//  ShouKeBao.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "ShouKeBao.h"
#import "MJRefresh.h"
#import "OrderCell.h"
#import "OrderModel.h"
#import "SearchProductViewController.h"
#import "tableviewCell.h"
#import "StationSelect.h"
#import "StoreViewController.h"
@interface ShouKeBao ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)changeStation:(id)sender;
- (IBAction)phoneToService:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *yesterDayOrderCount;
@property (weak, nonatomic) IBOutlet UILabel *yesterdayVisitors;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UITableView *midlleTable;
@property (weak, nonatomic) IBOutlet UITableView *downTable;
@property (weak, nonatomic) IBOutlet UIView *upView;

- (IBAction)search:(id)sender;

- (IBAction)add:(id)sender;
@end

@implementation ShouKeBao

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customLeftBarItem];
    [self customRightBarItem];
    self.searchBtn.layer.cornerRadius = 4;
    self.searchBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.searchBtn.layer.borderWidth = 0.5f;
    self.searchBtn.layer.masksToBounds = YES;
   // [self iniHeader];
  
    self.midlleTable.rowHeight = 40;
    self.downTable.rowHeight = 40;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToStore)];
    [self.upView addGestureRecognizer:tap];
}
-(void)pushToStore
{
    StoreViewController *store =  [[StoreViewController alloc] init];
    store.PushUrl = @"http://skb.lvyouquan.cn/mc/kaifaceshi/";
    [self.navigationController pushViewController:store animated:YES];

}
-(void)customLeftBarItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
    [button setImage:[UIImage imageNamed:@"navRing"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(ringAction)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem= barItem;
}
-(void)customRightBarItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
    [button setImage:[UIImage imageNamed:@"navCode"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(codeAction)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem= barItem;
}
-(void)ringAction
{

}
-(void)codeAction
{

}
//-(void)iniHeader
//{    //下啦刷新
//    [self.table addHeaderWithTarget:self action:@selector(headRefresh) dateKey:nil];
//    [self.table headerBeginRefreshing];
//    //上啦刷新
//    [self.table addFooterWithTarget:self action:@selector(footRefresh)];
//    //设置文字
//    self.table.headerPullToRefreshText = @"下拉刷新";
//    self.table.headerRefreshingText = @"正在刷新中";
//    
//    self.table.footerPullToRefreshText = @"上拉刷新";
//    self.table.footerRefreshingText = @"正在刷新";
//}
//
//-(void)headRefresh
//{
//    
//    [self dataArr];//懒加载
//    //上拉刷新,一般在此方法内添加刷新内容
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
//        [self.table headerEndRefreshing];
//    });
//}
//-(void)footRefresh
//{
//    [self dataArr];//懒加载
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
//        [self.table footerEndRefreshing];
//    });
//    
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return 4;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
   
         tableviewCell *cell = [tableviewCell cellWithTableView:tableView];
        
        return cell;
    }
     tableviewCell *cell = [tableviewCell cellWithTableView:tableView];
    
    return cell;
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeStation:(id)sender {
    
    [self.navigationController pushViewController:[[StationSelect alloc] init] animated:YES];
}

- (IBAction)phoneToService:(id)sender {

}

- (IBAction)search:(id)sender {
    
    SearchProductViewController *searchVC = [[SearchProductViewController alloc] init];
   
    [self.navigationController pushViewController:searchVC animated:YES];

}

- (IBAction)add:(id)sender {
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}
@end
