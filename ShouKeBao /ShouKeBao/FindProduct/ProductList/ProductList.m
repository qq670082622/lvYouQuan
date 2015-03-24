//
//  ProductList.m
//  ShouKeBao
//
//  Created by David on 15/3/17.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "ProductList.h"
#import "ProductCell.h"
#import "ProductModal.h"
#import "IWHttpTool.h"
#import "MJRefresh.h"
#import "ProductModal.h"
#import "FootView.h"
@interface ProductList ()<UITableViewDelegate,UITableViewDataSource,footViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *setUpView;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property (copy , nonatomic) NSMutableString *page;

- (IBAction)recommond:(id)sender;
- (IBAction)profits:(id)sender;
- (IBAction)cheapPrice:(id)sender;

@end

@implementation ProductList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customRightBarItem];
    self.table.delegate = self;
    self.table.dataSource = self;
    //[self initRefresh];
    [self dataArr];
    self.page = [NSMutableString stringWithFormat:@"1"];
    
    FootView *foot = [FootView footView];
    foot.delegate = self;
    self.table.tableFooterView = foot;
    }
#pragma footView - delegate
-(void)footViewDidClickedLoadBtn:(FootView *)footView
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"10" forKey:@"Substation"];
    [dic setObject:@"10" forKey:@"PageSize"];
    [dic setObject:_page forKey:@"PageIndex"];
    NSLog(@"-------page2 请求的 dic  is %@-----",dic);
    [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
//        NSMutableArray *dicArr = [NSMutableArray array];
        for (NSDictionary *dic in json[@"ProductList"]) {
            ProductModal *modal = [ProductModal modalWithDict:dic];
            [self.dataArr addObject:modal];          }
        
        //[self.dataArr removeAllObjects];//移除
      //  _dataArr = dicArr;
        [self.table reloadData];
        NSString *page = [NSString stringWithFormat:@"%@",_page];
        self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
        NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
    } failure:^(NSError *error) {
        NSLog(@"-------产品搜索请求失败 error is%@----------",error);
    }];

// [self.dataArr addObject:mod];
   // [self.table reloadData];
}
#pragma mark - private
-(void)customRightBarItem
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
    [button setImage:[UIImage imageNamed:@"APPsaixuan"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(setUp)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem= barItem;
}

-(void)setUp
{
   
    if (self.setUpView.hidden == NO) {
        self.setUpView.hidden = YES;
        
      
    }else if (self.setUpView.hidden == YES){
        self.setUpView.hidden = NO;
       
    }
    
    }

//#pragma mark - private
//-(void)initRefresh
//{
//    //下啦刷新
//    [self.table addHeaderWithTarget:self action:@selector(rightheadRefresh) dateKey:nil];
//    [self.table headerBeginRefreshing];
//    //上啦刷新
//    [self.table addFooterWithTarget:self action:@selector(rightfootRefresh)];
//    [self.table footerBeginRefreshing];
//    //设置文字
//    self.table.headerPullToRefreshText = @"下拉刷新";
//    self.table.headerRefreshingText = @"正在刷新中";
//    
//    self.table.footerPullToRefreshText = @"上拉刷新";
//    self.table.footerRefreshingText = @"正在刷新";
//    
//    //下啦刷新
//    [self.table addHeaderWithTarget:self action:@selector(rightheadRefresh) dateKey:nil];
//    [self.table headerBeginRefreshing];
//    //上啦刷新
//    [self.table addFooterWithTarget:self action:@selector(rightfootRefresh)];
//    [self.table footerBeginRefreshing];
//    //设置文字
//    self.table.headerPullToRefreshText = @"下拉刷新";
//    self.table.headerRefreshingText = @"正在刷新中";
//    
//    self.table.footerPullToRefreshText = @"上拉刷新";
//    self.table.footerRefreshingText = @"正在刷新";
//}
//
//-(void)rightheadRefresh
//{//上拉刷新,一般在此方法内添加刷新内容
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
//        [self dataArr];
//        
//        [self.table headerEndRefreshing];
//        [self.table reloadData];
//    });
//}
//
//-(void)rightfootRefresh
//{//下拉刷新
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 2.0s后执行block里面的代码
//        [self dataArr];
//        [self.table footerEndRefreshing];
//        [self.table reloadData];
//    });
//}
#pragma mark - getter
-(NSArray *)dataArr
{
    if (_dataArr == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        self.page = [NSMutableString stringWithFormat:@"1"];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
          NSMutableArray *dicArr = [NSMutableArray array];
          for (NSDictionary *dic in json[@"ProductList"]) {
              ProductModal *modal = [ProductModal modalWithDict:dic];
              [dicArr addObject:modal];
          }
         
            //[self.dataArr removeAllObjects];//移除
            _dataArr = dicArr;
            [self.table reloadData];
            
          NSLog(@"----------productList dataArr-is-%@-------",_dataArr);
            NSString *page = [NSString stringWithFormat:@"%@",_page];
            self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
      } failure:^(NSError *error) {
          NSLog(@"-------产品搜索请求失败 error is%@----------",error);
      }];
    }

    return _dataArr;
   
}

#pragma mark - tableviewdatasource& tableviewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModal *model = _dataArr[indexPath.row];
    NSString *productUrl = model.LinkUrl;
    ProduceDetailViewController *detail = [[ProduceDetailViewController alloc] init];
    detail.produceUrl = productUrl;
    [self.navigationController pushViewController:detail animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [ProductCell cellWithTableView:tableView];
    cell.modal = _dataArr[indexPath.row];
    return  cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)recommond:(id)sender {
}

- (IBAction)profits:(id)sender {
}

- (IBAction)cheapPrice:(id)sender {
}
@end
