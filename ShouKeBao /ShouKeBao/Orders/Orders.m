//
//  Orders.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "Orders.h"
#import "MJRefresh.h"
#import "orderCell.h"
#import "oderMoal.h"
@interface Orders ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation Orders

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"理订单";
    [self customRightBarItem];
    [self iniHeader];
    self.table.delegate = self;
    self.table.dataSource = self;

}
-(void)customRightBarItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
    [button setImage:[UIImage imageNamed:@"orderSelect"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(selectAction)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem= barItem;
}
-(void)selectAction
{

}

-(void)iniHeader
{    //下啦刷新
    [self.table addHeaderWithTarget:self action:@selector(headRefresh) dateKey:nil];
    [self.table headerBeginRefreshing];
    //上啦刷新
    [self.table addFooterWithTarget:self action:@selector(footRefresh)];
    //设置文字
    self.table.headerPullToRefreshText = @"下拉刷新";
    self.table.headerRefreshingText = @"正在刷新中";
    
    self.table.footerPullToRefreshText = @"上拉刷新";
    self.table.footerRefreshingText = @"正在刷新";
}

-(void)headRefresh
{
    
    [self dataArr];//懒加载
    //上拉刷新,一般在此方法内添加刷新内容
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
        [self.table headerEndRefreshing];
    });
}
-(void)footRefresh
{
    [self dataArr];//懒加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
        [self.table footerEndRefreshing];
    });
    
}

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        //      [IWHttpTool postWithURL4:@"http://192.168.2.101:81/moble/MobleCallBack.html" params:_listArr  method:@"PhoneFriend" success:^(id json) {
        //          NSLog(@"成功！ ～～～取到的联系人%@",json);
        //          NSDictionary *resultDic = json[@"result"];
        //          NSMutableArray *dicArr ;
        //          for (NSDictionary *dic in resultDic) {
        //              ContactModal *mod = [ContactModal modalWithDict:dic];
        //              [dicArr addObject:mod];
        //          }
        //          _dataArr = dicArr;
        //      } failure:^(NSError *error) {
        //          NSLog(@"失败!~~~~~~原因：%@",error);
        //      }];
        
    }
    
    
    return _dataArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return    self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    orderCell *cell = [orderCell cellWithTableView:tableView];
    cell.modal = _dataArr[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
