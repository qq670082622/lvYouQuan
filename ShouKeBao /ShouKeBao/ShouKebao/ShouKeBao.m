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
@interface ShouKeBao ()

@end

@implementation ShouKeBao

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customLeftBarItem];
    [self customRightBarItem];
   
   // [self iniHeader];
  

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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
