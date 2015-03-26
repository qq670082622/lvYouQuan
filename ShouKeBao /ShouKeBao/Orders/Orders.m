//
//  Orders.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "Orders.h"
#import "MJRefresh.h"
#import "OrderCell.h"
#import "OrderModel.h"
#import "DOPDropDownMenu.h"
#import "OrderTool.h"
#import "DressView.h"
#import "AreaViewController.h"
#import "MBProgressHUD+MJ.h"
#import "CalendarViewController.h"

@interface Orders () <DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,DressViewDelegate,AreaViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) DOPDropDownMenu *menu;
@property (nonatomic,strong) NSMutableArray *chooseTime;
@property (nonatomic,strong) NSMutableArray *chooseStatus;

@property (nonatomic,strong) NSMutableArray *firstAreaData;
@property (nonatomic,strong) NSDictionary *firstValue;// 选择大区以后获取值
@property (nonatomic,strong) NSDictionary *secondValue;// 选择二级区获取的值
@property (nonatomic,strong) NSDictionary *thirdValue;// 三级选择

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) DressView *dressView;
@property (nonatomic,weak) UIView *cover;

@end

@implementation Orders

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"理订单";
    self.view.window.windowLevel = UIWindowLevelAlert;
    
    // 导航按钮
    [self customRightBarItem];
    
    // 刷新控件
    [self iniHeader];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.menu];
    
    [self loadConditionData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickBack:) name:@"DressViewClickBack" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickReset:) name:@"DressViewClickReset" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickConfirm:) name:@"DressViewClickConfirm" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - loadDatasource
- (void)loadConditionData
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    [self.chooseTime removeAllObjects];
    [self.chooseStatus removeAllObjects];
    NSDictionary *param = @{};
    [OrderTool getOrderConditionWithParam:param success:^(id json) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].delegate.window animated:YES];
        if (json) {
            NSLog(@"----%@",json);
            if ([json[@"IsSuccess"] integerValue] == 1) {
                
                for (NSDictionary *timeDic in json[@"DateRangList"]) {
                    [self.chooseTime addObject:timeDic];
                }
                
                for (NSDictionary *statusDic in json[@"StateList"]) {
                    [self.chooseStatus addObject:statusDic];
                }
                
                for (NSDictionary *areaDic in json[@"FirstLevelArea"]) {
                    [self.firstAreaData addObject:areaDic];
                }
                
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadDataSuorceByCondition
{
    NSDictionary *param = @{@"KeyWord":@"",
                            @"CreatedDateRang":@"",
                            @"State":@"",
                            @"GoDateStart":@"",
                            @"GoDateEnd":@"",
                            @"FirstLevelArea":self.firstValue[@"Value"],
                            @"SecondLevelAreaID":self.secondValue[@"Value"],
                            @"ThirdLevelAreaID":self.thirdValue[@"Value"],
                            @"CreatedDateStart":@"",
                            @"CreatedDateEnd":@"",
                            @"IsRefund":[NSString stringWithFormat:@"%d",self.dressView.IsRefund.on]};
    [OrderTool getOrderListWithParam:param success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - private
// 自定义导航按钮
-(void)customRightBarItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
    [button setImage:[UIImage imageNamed:@"orderSelect"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(selectAction)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barItem;
}

// 点击筛选
- (void)selectAction
{
    UIView *cover = [[UIView alloc] initWithFrame:self.view.bounds];
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dressTapHandle:)];
    tap.delegate = self;
    [cover addGestureRecognizer:tap];
    self.cover = cover;
    
    // 筛选视图
    [cover addSubview:self.dressView];
    [self.view.window addSubview:cover];
}

// 去除筛选界面
- (void)dressTapHandle:(UITapGestureRecognizer *)ges
{
    [ges.view removeFromSuperview];
    [_dressView removeFromSuperview];
}

-(void)iniHeader
{    //下啦刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headRefresh) dateKey:nil];
    
    //上啦刷新
    [self.tableView addFooterWithTarget:self action:@selector(footRefresh)];
    //设置文字
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉刷新";
    self.tableView.footerRefreshingText = @"正在刷新";
}

-(void)headRefresh
{
    
    [self dataArr];//懒加载
    //上拉刷新,一般在此方法内添加刷新内容
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
        [self.tableView headerEndRefreshing];
    });
}
-(void)footRefresh
{
    [self dataArr];//懒加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
        [self.tableView footerEndRefreshing];
    });
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self.cover) {
        return YES;
    }
    return NO;
}

#pragma mark - getter
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)chooseTime
{
    if (!_chooseTime) {
        _chooseTime = [NSMutableArray array];
    }
    return _chooseTime;
}

- (NSMutableArray *)chooseStatus
{
    if (!_chooseStatus) {
        _chooseStatus = [NSMutableArray array];
    }
    return _chooseStatus;
}

- (NSMutableArray *)firstAreaData
{
    if (!_firstAreaData) {
        _firstAreaData = [NSMutableArray array];
    }
    return _firstAreaData;
}

- (DOPDropDownMenu *)menu
{
    if (!_menu) {
        _menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
        _menu.dataSource = self;
        _menu.delegate = self;
    }
    return _menu;
}

- (DressView *)dressView
{
    if (!_dressView) {
        _dressView = [[DressView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 300, 0, 300, self.view.window.bounds.size.height)];
        _dressView.delegate = self;
    }
    return _dressView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - DOPDropDownMenuDataSource,DOPDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.chooseTime.count;
    }else{
        return self.chooseStatus.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    if (self.chooseTime.count || self.chooseStatus.count) {
        if (indexPath.column == 0) {
            return self.chooseTime[indexPath.row][@"Text"];
        }else{
            return self.chooseStatus[indexPath.row][@"Text"];
        }
    }else{
        if (indexPath.column == 0) {
            return @"时间";
        }else{
            return @"状态";
        }
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [OrderCell cellWithTableView:tableView];
    
    return cell;
}

#pragma mark - DressViewDelegate
- (void)wantToPushAreaWithType:(areaType)type
{
    AreaViewController *area = [[AreaViewController alloc] init];
    area.delegate = self;
    
    if (type == firstArea){
        self.cover.hidden = YES;
        area.type = firstArea;
        area.dataSource = self.firstAreaData;
        [self.navigationController pushViewController:area animated:YES];
    }else if (type == secondArea){
        if (self.firstValue) {
            // 获取二级列表
            NSDictionary *param = @{@"FirstLevelArea":self.firstValue[@"Value"]};
            [OrderTool getSecondLevelAreaWithParam:param success:^(id json) {
                if (json) {
                    NSLog(@"-----%@",json);
                    NSMutableArray *tmp = [NSMutableArray array];
                    for (NSDictionary *dic in json[@"LevelAreaList"]) {
                        [tmp addObject:dic];
                    }
                    self.cover.hidden = YES;
                    area.type = secondArea;
                    area.dataSource = tmp;
                    [self.navigationController pushViewController:area animated:YES];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }else{// 点击三级区域
        if (self.secondValue) {
            // 获取三级级列表
            NSDictionary *param = @{@"SecondLevelAreaID":self.secondValue[@"Value"]};
            [OrderTool getThirdLevelAreaWithParam:param success:^(id json) {
                if (json) {
                    NSLog(@"-----%@",json);
                    NSMutableArray *tmp = [NSMutableArray array];
                    for (NSDictionary *dic in json[@"LevelAreaList"]) {
                        [tmp addObject:dic];
                    }
                    self.cover.hidden = YES;
                    area.type = thirdArea;
                    area.dataSource = tmp;
                    [self.navigationController pushViewController:area animated:YES];
                }
            } failure:^(NSError *error) {
                
            }];

        }
    }
}

- (void)didSelectedTimeWithType:(timeType)type
{
    self.cover.hidden = YES;
    CalendarViewController *calendar = [[CalendarViewController alloc] init];
    [self.navigationController pushViewController:calendar animated:YES];
}

#pragma mark - DressViewNotification
- (void)clickBack:(NSNotification *)noty
{
    [self.cover removeFromSuperview];
}

- (void)clickReset:(NSNotification *)noty
{
    [self.firstAreaData removeAllObjects];
    self.firstValue = nil;
    self.secondValue = nil;
    self.thirdValue = nil;
    
    self.dressView.firstText = nil;
    self.dressView.secondText = nil;
    self.dressView.thirdText = nil;
    [self.dressView.tableView reloadData];
    [self loadConditionData];
}

- (void)clickConfirm:(NSNotification *)noty
{
    [self.cover removeFromSuperview];
}

#pragma mark - AreaViewControllerDelegate
// 选择之后把值返回过来
- (void)didSelectAreaWithValue:(NSDictionary *)value Type:(areaType)type
{
    if (type == firstArea) {
        self.firstValue = value;
        self.dressView.firstText = value[@"Text"];
    }else if(type == secondArea){
        self.secondValue = value;
        self.dressView.secondText = value[@"Text"];
    }else{
        self.thirdValue = value;
        self.dressView.thirdText = value[@"Text"];
    }
    
    self.cover.hidden = NO;
    [self.dressView.tableView reloadData];
}


@end
