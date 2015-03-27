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
#import "StrToDic.h"
#import "ConditionSelectViewController.h"
#import "ConditionModel.h"
#import "MBProgressHUD+MJ.h"
#import "SearchProductViewController.h"
@interface ProductList ()<UITableViewDelegate,UITableViewDataSource,footViewDelegate,MGSwipeTableCellDelegate,passValue>
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
@property (strong,nonatomic) NSMutableDictionary *conditionDic;//当前条件开关
@property (strong,nonatomic) NSMutableArray *conditionArr;//post装载的条件数据
@property (strong,nonatomic) NSArray *subDataArr1;
@property (strong,nonatomic) NSArray *subDataArr2;
@property (strong,nonatomic) NSMutableArray *subIndicateDataArr1;
@property (strong,nonatomic) NSMutableArray *subIndicateDataArr2;
@property (strong,nonatomic) NSMutableString *turn;
@property (weak , nonatomic) UIButton *subTableSectionBtn;
@property (copy,nonatomic) NSMutableString *jiafan;
@property (copy,nonatomic) NSMutableString *jishi;
//
//@property (nonatomic,strong) NSMutableString *ProductBrowseTag;//游览线路ID
//@property (nonatomic,strong) NSMutableString *GoDate;//出发日期
//@property (nonatomic,strong) NSMutableString *ScheduleDays;//行程时间
//@property (nonatomic,strong) NSMutableString *StartCity;//出发城市
//@property (nonatomic,strong) NSMutableString *ProductThemeTag;//主题推荐iD
//@property (nonatomic,strong) NSMutableString *Supplier;//供应商ID
//@property (nonatomic,strong) NSMutableString *HotelStandard;//酒店类型
//@property (nonatomic,strong) NSMutableString *TrafficType;//出行方式
//@property (nonatomic,strong) NSMutableString *CruiseShipCompany;//油轮公司
//@property (nonatomic,strong) NSMutableString *ProductLevel;//线路等级
@end

@implementation ProductList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = self.title;
    [self customRightBarItem];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.subTable.delegate = self;
    self.subTable.dataSource = self;
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
    
    self.jiafan = [NSMutableString stringWithFormat:@"1"];
    self.jishi = [NSMutableString stringWithFormat:@"1"];
    
    self.subDataArr1 = [NSArray arrayWithObjects:@"游览线路      ",@"出发日期      ",@"出发城市      ",@"主题推荐      ",@"供应商      ", nil];//5
    self.subDataArr2 = [NSArray arrayWithObjects:@"酒店类型      ",@"出行方式      ",@"油轮公司      ",@"线路等级      ", nil];//4
    self.subIndicateDataArr1 = [NSMutableArray arrayWithObjects:@" ",@" ",@" ",@" ",@" ", nil];
    self.subIndicateDataArr2 = [NSMutableArray arrayWithObjects:@" ",@" ",@" ",@" ", nil];
    self.turn = [NSMutableString stringWithFormat:@"Off"];

    
//    ConditionSelectViewController *conditionVC = [[ConditionSelectViewController alloc] init];
//    conditionVC.delegate = self;

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 28)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 220, 28);
    [btn setBackgroundImage:[UIImage imageNamed:@"searchBar"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickPush) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn];
    self.navigationItem.titleView = titleView;
    
    }
-(void)clickPush
{
    [self.navigationController pushViewController:[[SearchProductViewController alloc] init] animated:YES];
}

#pragma  mark - conditionDetail delegate//key 指大字典的key value指字典中某一子value的值
-(void)passKey:(NSString *)key andValue:(NSString *)value andSelectIndexPath:(NSArray *)selectIndexPath andSelectValue:(NSString *)selectValue
{
    //确认列表选择值
    [self.conditionDic setObject:value forKey:key];
     NSLog(@"-----------conditionDic is %@--------",self.conditionDic);//-------------crash conditionDic is nil
    //确认加返
    if (self.jiafanSwitch.selected  == YES) {
        self.jiafan = [NSMutableString stringWithFormat:@"1"];
    }else if (self.jiafanSwitch.selected == NO){
        self.jiafan = [NSMutableString stringWithFormat:@"0"];
    }
    //确认及时
    if (self.jishiSwitch.selected == YES) {
        self.jishi = [NSMutableString stringWithFormat:@"1"];
    }else if (self.jishiSwitch.selected == NO){
        self.jishi = [NSMutableString stringWithFormat:@"0"];
    }
    
    [self.conditionDic setObject:_jiafan forKey:@"IsPersonBackPrice"];
   
    [self.conditionDic setObject:_jishi forKey:@"IsComfirmStockNow"];
      NSLog(@"-----------conditionDic is %@-- jiafan is %@--   jishi is %@----",_jiafan,_jishi, self.conditionDic);
    if ([selectIndexPath[0]isEqualToString:@"0"]) {
        NSInteger a = [selectIndexPath[1] integerValue];//分析selected IndexPath.row的值
       
        self.subIndicateDataArr1[a] = selectValue;
    }else if ([selectIndexPath[0] isEqualToString:@"1"]){
       
        NSInteger a = [selectIndexPath[1] integerValue];
        self.subIndicateDataArr2[a] = selectValue;
    }
    
    [self.subTable reloadData];
    NSLog(@"-----------conditionDic is %@--------",self.conditionDic);
    //  NSLog(@"----------passKey is %@ Value iS  %@selectIndexPath is %@    selectValue is%@-------------",key,value,selectIndexPath,selectValue);
    
}

#pragma footView - delegate
-(void)footViewDidClickedLoadBtn:(FootView *)footView
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:[self conditionDic]];//增加筛选条件
    [dic setObject:@"10" forKey:@"Substation"];
    [dic setObject:@"10" forKey:@"PageSize"];
    [dic setObject:_page forKey:@"PageIndex"];
    [dic setObject:_ProductSortingType forKey:@"ProductSortingType"];
   // NSLog(@"-------page2 请求的 dic  is %@-----",dic);
    [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
for (NSDictionary *dic in json[@"ProductList"]) {
            ProductModal *modal = [ProductModal modalWithDict:dic];
            [self.dataArr addObject:modal];          }
        
        [self.table reloadData];
        NSString *page = [NSString stringWithFormat:@"%@",_page];
        self.page = [NSMutableString stringWithFormat:@"%d",[page intValue]+1];
      //  NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
    } failure:^(NSError *error) {
        NSLog(@"-------产品搜索请求失败 error is%@----------",error);
    }];


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
#pragma 筛选navitem
-(void)setUp
{
   if (self.subView.hidden == YES) {
        self.subView.hidden = NO;
        }
}


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
         
            NSLog(@"--------------json[condition is  %@------------]",json[@"ProductConditionList"]);
            
            NSMutableArray *dicArr = [NSMutableArray array];
          for (NSDictionary *dic in json[@"ProductList"]) {
              ProductModal *modal = [ProductModal modalWithDict:dic];
              [dicArr addObject:modal];
          }
            
            NSMutableArray *conArr = [NSMutableArray array];
          
            for(NSDictionary *dic in json[@"ProductConditionList"] ){
                    [conArr addObject:dic];
            }
            
            _conditionArr = conArr;//装载筛选条件数据
           // NSLog(@"----------------conditionArr is %@----------",_conditionArr);
            _dataArr = dicArr;//装载产品列表数据
            [self.table reloadData];
            
            [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].delegate window] animated:YES];
            
         // NSLog(@"----------productList dataArr-is-%@-------",_dataArr);
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
    if (tableView.tag == 1) {
        return 140;
    }
    return 30;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1){
        return _dataArr.count;}
    if (tableView.tag == 2) {
        if (section == 0) {
            NSLog(@"-------%lu",(unsigned long)_subDataArr1.count);
            return _subDataArr1.count;
        }
        if (section == 1 && [_turn isEqualToString:@"On" ]) {
            NSLog(@"-------%lu",(unsigned long)_subDataArr2.count);
            return _subDataArr2.count;
        }

    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 2) {
        return 2;
    }
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{  if(tableView.tag == 2){
    if(section == 1 && [_turn isEqualToString:@"Off"]){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height)];
        view.userInteractionEnabled = YES;
        
        view.backgroundColor = [UIColor grayColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
        [btn setTitle:@"收起           >" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(beMore) forControlEvents:UIControlEventTouchUpInside];
        self.subTableSectionBtn = btn;
        [view addSubview:btn];
        return view;
    }else if (section == 1 && [_turn isEqualToString:@"On"]){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height)];
        view.userInteractionEnabled = YES;
        
        view.backgroundColor = [UIColor grayColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
        [btn setTitle:@"更多        >" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(beMore) forControlEvents:UIControlEventTouchUpInside];
        self.subTableSectionBtn = btn;
        [view addSubview:btn];
        return view;
    }
}
    return 0;
    
}
-(void)beMore
{
    NSLog(@"点击了butn");
    if ([_turn isEqualToString:@"Off"]) {
        self.turn = [NSMutableString stringWithString:@"On"];
    }
    else
        self.turn = [NSMutableString stringWithString:@"Off"];
    [self.subTable reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return 35;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        ProductModal *model = _dataArr[indexPath.row];
        NSString *productUrl = model.LinkUrl;
        ProduceDetailViewController *detail = [[ProduceDetailViewController alloc] init];
        detail.produceUrl = productUrl;
        [self.navigationController pushViewController:detail animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (tableView.tag == 2) {
    
        NSInteger a = (5*(indexPath.section)) + (indexPath.row);//获得当前点击的row行数
    
        //    NSLog(@"-------------a is %ld  ----_conditionArr[a] is %@------------",(long)a,_conditionArr[a]);
       NSDictionary *conditionDic = _conditionArr[a];
        ConditionSelectViewController *conditionVC = [[ConditionSelectViewController alloc] init];
        conditionVC.delegate = self;
        conditionVC.conditionDic = conditionDic;
        
        NSArray *arr = [NSArray arrayWithObjects:[NSString  stringWithFormat:@"%ld",(long)indexPath.section],[NSString  stringWithFormat:@"%ld",(long)indexPath.row], nil];
        conditionVC.superViewSelectIndexPath = arr;//取出第几行被选择
  
        //取出conditionVC的navTile
        NSString *conditionVCTile;
        if (indexPath.section == 0) {
            conditionVCTile = _subDataArr1[indexPath.row];
        }else if (indexPath.section == 1){
            conditionVCTile = _subDataArr2[indexPath.row];
        }
        conditionVC.title = conditionVCTile;
        
       
        //    NSLog(@"-----------conditionVC.conditionDic is %@---------",conditionVC.conditionDic);
        [self.navigationController pushViewController:conditionVC animated:YES];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        ProductCell *cell = [ProductCell cellWithTableView:tableView];
        
        ProductModal *model = _dataArr[indexPath.row];
        cell.modal = model;
        
        cell.delegate = self;
        
        // cell的滑动设置
        cell.leftSwipeSettings.transition = MGSwipeTransitionStatic;
        cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
        
        cell.leftButtons = [self createLeftButtons:model];
        cell.rightButtons = [self createRightButtons:model];
        return cell;
    }
  
   if (tableView.tag == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
       
       if (indexPath.section == 0) {
           cell.textLabel.font = [UIFont systemFontOfSize:13];
           cell.textLabel.text =  [NSString stringWithFormat:@"%@",self.subDataArr1[indexPath.row]];
           cell.detailTextLabel.font = [UIFont systemFontOfSize:11.0];
           cell.detailTextLabel.text = self.subIndicateDataArr1[indexPath.row];
       }else {
           cell.textLabel.text = [NSString stringWithFormat:@"%@",self.subDataArr2[indexPath.row]];
           cell.textLabel.font = [UIFont systemFontOfSize:13];
           cell.textLabel.text =  [NSString stringWithFormat:@"%@",self.subDataArr2[indexPath.row]];
           cell.detailTextLabel.font = [UIFont systemFontOfSize:11.0];
           cell.detailTextLabel.text = self.subIndicateDataArr2[indexPath.row];
           
       }
       return cell;
    }
    return  0;
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
     [dic addEntriesFromDictionary:_conditionDic];//增加筛选条件
    NSLog(@"----------增加的conditionDic is %@------------",_conditionDic);
    [dic setObject:@"10" forKey:@"Substation"];
    [dic setObject:@"10" forKey:@"PageSize"];
    [dic setObject:@1 forKey:@"PageIndex"];
    [dic setObject:@"0" forKey:@"ProductSortingType"];
   // NSLog(@"-------page2 请求的 dic  is %@-----",dic);
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
      //  NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
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
         [dic addEntriesFromDictionary:_conditionDic];//增加筛选条件
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
          //  NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];
        

    }else if (self.profitOutlet.selected == YES && [self.profitOutlet.titleLabel.text
                                                    isEqualToString:@"利润 ↑"]){
        [self.profitOutlet setTitle:@"利润 ↓" forState:UIControlStateNormal];
               NSMutableDictionary *dic = [NSMutableDictionary dictionary];
         [dic addEntriesFromDictionary:_conditionDic];//增加筛选条件
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"1" forKey:@"ProductSortingType"];
       // NSLog(@"-------page2 请求的 dic  is %@-----",dic);
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
            //NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];
    }else if (self.profitOutlet.selected == YES && [self.profitOutlet.titleLabel.text isEqualToString:@"利润 ↓"]){
    [self.profitOutlet setTitle:@"利润 ↑" forState:UIControlStateNormal];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
         [dic addEntriesFromDictionary:_conditionDic];//增加筛选条件
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"2" forKey:@"ProductSortingType"];
      //  NSLog(@"-------page2 请求的 dic  is %@-----",dic);
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
          //  NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
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
         [dic addEntriesFromDictionary:_conditionDic];//增加筛选条件
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"4" forKey:@"ProductSortingType"];
       // NSLog(@"-------page2 请求的 dic  is %@-----",dic);
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
          //  NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];

    }else if (self.cheapOutlet.selected == YES && [self.cheapOutlet.titleLabel.text
                                                   isEqualToString:@"同行价 ↑"]){
        [self.cheapOutlet setTitle:@"同行价 ↓" forState:UIControlStateNormal];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
         [dic addEntriesFromDictionary:_conditionDic];//增加筛选条件
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"3" forKey:@"ProductSortingType"];
       // NSLog(@"-------page2 请求的 dic  is %@-----",dic);
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
         //   NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];

    }else if (self.cheapOutlet.selected == YES &&[self.cheapOutlet.titleLabel.text isEqualToString:@"同行价 ↓"]){
    [self.cheapOutlet setTitle:@"同行价 ↑" forState:UIControlStateNormal];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
         [dic addEntriesFromDictionary:_conditionDic];//增加筛选条件
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@1 forKey:@"PageIndex"];
        [dic setObject:@"4" forKey:@"ProductSortingType"];
      //  NSLog(@"-------page2 请求的 dic  is %@-----",dic);
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
         //   NSLog(@"---------转化后的page is %@ +1后的 page is -------%@----",page,_page);
        } failure:^(NSError *error) {
            NSLog(@"-------产品搜索请求失败 error is%@----------",error);
        }];

    }
}

- (IBAction)sunCancel:(id)sender {
    self.subView.hidden = YES;
}

- (IBAction)subReset:(id)sender {
    
}

- (IBAction)subDone:(id)sender {
    self.subView.hidden = YES;
    [self recommond:sender];
    [self.commondOutlet setSelected:YES];
    self.profitOutlet.selected = NO;
    self.cheapOutlet.selected = NO;
}

- (IBAction)subMinMax:(id)sender {
    
}


- (IBAction)jiafanSwitchAction:(id)sender {
   
    
}

- (IBAction)jishiSwitchAction:(id)sender {
    
}

//-(NSMutableDictionary *)conditionDic
//{
//    
//    return _conditionDic;
//}
@end
