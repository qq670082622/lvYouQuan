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
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"

@interface ProductList ()<UITableViewDelegate,UITableViewDataSource,footViewDelegate,MGSwipeTableCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *subView;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property (copy , nonatomic) NSMutableString *page;
@property (weak, nonatomic) IBOutlet UITableView *subTable;
- (IBAction)sunCancel:(id)sender;
- (IBAction)subReset:(id)sender;
- (IBAction)subDone:(id)sender;
- (IBAction)subMinMax:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *jiafanSwitch;

- (IBAction)jiafanSwitchAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *jishiSwitch;
- (IBAction)jishiSwitchAction:(id)sender;

@property (copy , nonatomic) NSMutableString *ProductSortingType;//推荐:”0",利润（从低往高）:”1"利润（从高往低:”2"
//同行价（从低往高）:”3,同行价（从高往低）:"4"
- (IBAction)recommond:(id)sender;
- (IBAction)profits:(id)sender;
- (IBAction)cheapPrice:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commondOutlet;
@property (weak, nonatomic) IBOutlet UIButton *profitOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cheapOutlet;

@end

@implementation ProductList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = self.title;
    [self customRightBarItem];
    self.table.delegate = self;
    self.table.dataSource = self;
    //[self initRefresh];
    [self dataArr];
    self.page = [NSMutableString stringWithFormat:@"1"];
    self.ProductSortingType = [NSMutableString stringWithFormat:@"0"];
    FootView *foot = [FootView footView];
    foot.delegate = self;
    self.table.tableFooterView = foot;
    [self.commondOutlet setSelected:YES];
    
    [self.profitOutlet setTitle:@"利润 ↑" forState:UIControlStateNormal ];
    [self.cheapOutlet setTitle:@"同行价 ↑" forState:UIControlStateNormal ];
    
    }
#pragma footView - delegate
-(void)footViewDidClickedLoadBtn:(FootView *)footView
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"10" forKey:@"Substation"];
    [dic setObject:@"10" forKey:@"PageSize"];
    [dic setObject:_page forKey:@"PageIndex"];
    [dic setObject:_ProductSortingType forKey:@"ProductSortingType"];
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
   
    if (self.subView.hidden == NO) {
        self.subView.hidden = YES;
        
      
    }else if (self.subView.hidden == YES){
        self.subView.hidden = NO;
       
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

// 左边滑动的按钮
- (NSArray *)createLeftButtons:(ProductModal *)model
{
    NSString *tmp = [NSString stringWithFormat:@"%@ %@",model.ContactName,model.ContactMobile];
    NSMutableArray * result = [NSMutableArray array];
    UIColor * color = [UIColor lightGrayColor];
    
    MGSwipeButton * button = [MGSwipeButton buttonWithTitle:tmp icon:nil backgroundColor:color callback:^BOOL(MGSwipeTableCell * sender){
        NSLog(@"Convenience callback received (left).");
        return YES;
    }];
    CGRect frame = button.frame;
    frame.size.width = 50;
    button.frame = frame;
    [result addObject:button];
    button.enabled = NO;
    
    return result;
}

// 右边滑动的按钮
- (NSArray *)createRightButtons:(ProductModal *)model
{
    NSMutableArray * result = [NSMutableArray array];
    NSString *add = [NSString stringWithFormat:@"最近班期:%@\n\n供应商:%@",model.LastScheduleDate,model.SupplierName];
    NSString* titles[2] = {@"", add};
    UIColor * colors[2] = {[UIColor clearColor], [UIColor lightGrayColor]};
    for (int i = 0; i < 2; i ++)
    {
        MGSwipeButton *button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (right). %d",i);
            return YES;
        }];
        
        if (i == 0) {
            NSString *img = [model.IsFavorites isEqualToString:@"1"] ? @"uncollection_icon" : @"collection_icon";
            [button setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        }else{
            button.titleLabel.numberOfLines = 0;
            button.enabled = NO;
        }
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        CGRect frame = button.frame;
        frame.size.width = i == 1 ? 200 : 50;
        button.frame = frame;
        
        [result addObject:button];
    }
    return result;
}

#pragma mark - tableviewdatasource& tableviewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModal *model = _dataArr[indexPath.row];
    NSString *productUrl = model.LinkUrl;
    ProduceDetailViewController *detail = [[ProduceDetailViewController alloc] init];
    detail.produceUrl = productUrl;
    [self.navigationController pushViewController:detail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [ProductCell cellWithTableView:tableView];
    
    ProductModal *model = _dataArr[indexPath.row];
    cell.modal = model;
    
    cell.delegate = self;
    
    // cell的滑动设置
    cell.leftSwipeSettings.transition = MGSwipeTransitionStatic;
    cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    
    cell.leftButtons = [self createLeftButtons:model];
    cell.rightButtons = [self createRightButtons:model];
    
    return  cell;
}

#pragma mark - MGSwipeTableCellDelegate
- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell canSwipe:(MGSwipeDirection)direction
{
    return YES;
}

- (NSArray *)swipeTableCell:(MGSwipeTableCell *)cell swipeButtonsForDirection:(MGSwipeDirection)direction swipeSettings:(MGSwipeSettings *)swipeSettings expansionSettings:(MGSwipeExpansionSettings *)expansionSettings
{
    return [NSArray array];
}

// 收藏按钮点击
- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{
    NSIndexPath *indexPath = [self.table indexPathForCell:cell];
    NSLog(@"------%@",indexPath);
    
    ProductModal *model = _dataArr[indexPath.row];
    NSString *result = [model.IsFavorites isEqualToString:@"0"]?@"1":@"0";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:model.ID forKey:@"ProductID"];
    [dic setObject:result forKey:@"IsFavorites"];///Product/ SetProductFavorites
   [IWHttpTool WMpostWithURL:@"/Product/SetProductFavorites" params:dic success:^(id json) {
       NSLog(@"产品收藏成功");
   } failure:^(NSError *error) {
       NSLog(@"产品收藏网络请求失败");
   }];
    return YES;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recommond:(id)sender {//推荐
    [self.profitOutlet setSelected:NO];
    [self.cheapOutlet setSelected:NO];
    [self.commondOutlet setSelected:YES];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"10" forKey:@"Substation"];
    [dic setObject:@"10" forKey:@"PageSize"];
    [dic setObject:@1 forKey:@"PageIndex"];
    [dic setObject:@"0" forKey:@"ProductSortingType"];
    NSLog(@"-------page2 请求的 dic  is %@-----",dic);
    [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
        [self.dataArr removeAllObjects];//移除
        NSMutableArray *dicArr = [NSMutableArray array];
        for (NSDictionary *dic in json[@"ProductList"]) {
            ProductModal *modal = [ProductModal modalWithDict:dic];
            [dicArr addObject:modal];
            }
        _dataArr = dicArr;
       
        
        [self.table reloadData];
        NSString *page = [NSString stringWithFormat:@"%@",_page];
        self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
        NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
    } failure:^(NSError *error) {
        NSLog(@"-------产品搜索请求失败 error is%@----------",error);
    }];

}

- (IBAction)profits:(id)sender {//利润2,1
    if (self.profitOutlet.selected == NO) {
        [self.profitOutlet setSelected:YES];
        [self.cheapOutlet setSelected:NO];
        [self.commondOutlet setSelected:NO];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"2" forKey:@"ProductSortingType"];
        NSLog(@"-------page2 请求的 dic  is %@-----",dic);
        [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
            [self.dataArr removeAllObjects];//移除
            NSMutableArray *dicArr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"ProductList"]) {
                ProductModal *modal = [ProductModal modalWithDict:dic];
                [dicArr addObject:modal];
            }
            _dataArr = dicArr;
            
            
            [self.table reloadData];
            NSString *page = [NSString stringWithFormat:@"%@",_page];
            self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
            NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];
        

    }else if (self.profitOutlet.selected == YES && [self.profitOutlet.titleLabel.text
                                                    isEqualToString:@"利润 ↑"]){
        [self.profitOutlet setTitle:@"利润 ↓" forState:UIControlStateNormal];
               NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"1" forKey:@"ProductSortingType"];
        NSLog(@"-------page2 请求的 dic  is %@-----",dic);
        [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
            [self.dataArr removeAllObjects];//移除
            NSMutableArray *dicArr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"ProductList"]) {
                ProductModal *modal = [ProductModal modalWithDict:dic];
                [dicArr addObject:modal];
            }
            _dataArr = dicArr;
            
            
            [self.table reloadData];
            NSString *page = [NSString stringWithFormat:@"%@",_page];
            self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
            NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];
    }else if (self.profitOutlet.selected == YES && [self.profitOutlet.titleLabel.text isEqualToString:@"利润 ↓"]){
    [self.profitOutlet setTitle:@"利润 ↑" forState:UIControlStateNormal];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"2" forKey:@"ProductSortingType"];
        NSLog(@"-------page2 请求的 dic  is %@-----",dic);
        [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
            [self.dataArr removeAllObjects];//移除
            NSMutableArray *dicArr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"ProductList"]) {
                ProductModal *modal = [ProductModal modalWithDict:dic];
                [dicArr addObject:modal];
            }
            _dataArr = dicArr;
            
            
            [self.table reloadData];
            NSString *page = [NSString stringWithFormat:@"%@",_page];
            self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
            NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];

   }
    }

- (IBAction)cheapPrice:(id)sender {//同行价4,3
    if (self.cheapOutlet.selected == NO) {
        [self.cheapOutlet setSelected:YES];
        [self.commondOutlet setSelected:NO];
        [self.profitOutlet setSelected:NO];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"4" forKey:@"ProductSortingType"];
        NSLog(@"-------page2 请求的 dic  is %@-----",dic);
        [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
            [self.dataArr removeAllObjects];//移除
            NSMutableArray *dicArr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"ProductList"]) {
                ProductModal *modal = [ProductModal modalWithDict:dic];
                [dicArr addObject:modal];
            }
            _dataArr = dicArr;
            
            
            [self.table reloadData];
            NSString *page = [NSString stringWithFormat:@"%@",_page];
            self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
            NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];

    }else if (self.cheapOutlet.selected == YES && [self.cheapOutlet.titleLabel.text
                                                   isEqualToString:@"同行价 ↑"]){
        [self.cheapOutlet setTitle:@"同行价 ↓" forState:UIControlStateNormal];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"3" forKey:@"ProductSortingType"];
        NSLog(@"-------page2 请求的 dic  is %@-----",dic);
        [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
            [self.dataArr removeAllObjects];//移除
            NSMutableArray *dicArr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"ProductList"]) {
                ProductModal *modal = [ProductModal modalWithDict:dic];
                [dicArr addObject:modal];
            }
            _dataArr = dicArr;
            
            
            [self.table reloadData];
            NSString *page = [NSString stringWithFormat:@"%@",_page];
            self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
            NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];

    }else if (self.cheapOutlet.selected == YES &&[self.cheapOutlet.titleLabel.text isEqualToString:@"同行价 ↓"]){
    [self.cheapOutlet setTitle:@"同行价 ↑" forState:UIControlStateNormal];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"4" forKey:@"ProductSortingType"];
        NSLog(@"-------page2 请求的 dic  is %@-----",dic);
        [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
            [self.dataArr removeAllObjects];//移除
            NSMutableArray *dicArr = [NSMutableArray array];
            for (NSDictionary *dic in json[@"ProductList"]) {
                ProductModal *modal = [ProductModal modalWithDict:dic];
                [dicArr addObject:modal];
            }
            _dataArr = dicArr;
            
            
            [self.table reloadData];
            NSString *page = [NSString stringWithFormat:@"%@",_page];
            self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
            NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];

    }
}
- (IBAction)sunCancel:(id)sender {
}

- (IBAction)subReset:(id)sender {
}

- (IBAction)subDone:(id)sender {
}

- (IBAction)subMinMax:(id)sender {
}
- (IBAction)jiafanSwitchAction:(id)sender {
}
- (IBAction)jishiSwitchAction:(id)sender {
}
@end
