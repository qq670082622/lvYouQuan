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
@interface ProductList ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *setUpView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *dataArr;

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
    [self dataArr];
    
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

#pragma mark - getter
-(NSArray *)dataArr
{
    if (_dataArr == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"10" forKey:@"Substation"];
        [dic setObject:@"10" forKey:@"PageSize"];
        [dic setObject:@"1" forKey:@"PageIndex"];
        //[self.dataArr removeAllObjects];
      [IWHttpTool WMpostWithURL:@"/Product/GetProductList" params:dic success:^(id json) {
          NSMutableArray *dicArr = [NSMutableArray array];
          for (NSDictionary *dic in json[@"ProductList"]) {
              ProductModal *modal = [ProductModal modalWithDict:dic];
              [dicArr addObject:modal];          }
          _dataArr = dicArr;
          
          NSLog(@"----------productList dataArr-is-%@-------",_dataArr);

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
