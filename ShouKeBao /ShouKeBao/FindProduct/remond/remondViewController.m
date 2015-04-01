//
//  remondViewController.m
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/31.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "remondViewController.h"
#import "addRemondViewController.h"
#import "IWHttpTool.h"
@interface remondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *dataArr;
- (IBAction)addRemond:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (strong,nonatomic) NSMutableArray *editArr;
- (IBAction)deletAction:(id)sender;

@end

@implementation remondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpRightButton];
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.table.rowHeight = 78;
     [self loadData];
}
-(void)setUpRightButton{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [button setBackgroundImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(EditCustomerDetail)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem= barItem;
}
-(void)EditCustomerDetail
{
    if (self.subView.hidden == NO) {
        self.subView.hidden = YES;
        self.deleBtn.hidden = NO;
        [self.table setEditing:YES animated:YES];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];

        [button setBackgroundImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
        
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        self.navigationItem.rightBarButtonItem= barItem;

    }else if (self.subView.hidden == YES){
        self.subView.hidden = NO;
        self.deleBtn.hidden = YES;
        [self.table setEditing:NO animated:YES];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
        
        [button setBackgroundImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        self.navigationItem.rightBarButtonItem= barItem;
    }
    
}

-(void)loadData
{
//    for (int i = 0; i<10; i++) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setValue:[NSString stringWithFormat:@"吃第%d次饭🍚",i+1] forKey:@"des"];
//        [dic setValue:[NSString stringWithFormat:@"拉第%d次屎💩",i+1] forKey:@"time"];
//        [self.dataArr addObject:dic];
//    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.ID forKey:@"CustomerID"];
    [IWHttpTool WMpostWithURL:@"/Customer/GetCustomerRemindList" params:dic success:^(id json) {
        NSLog(@"提醒列表json is %@",json);
    } failure:^(NSError *error) {
        NSLog(@"客户提醒列表请求错误 %@",error);
    }];
}

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)editArr
{
    if (_editArr == nil) {
        self.editArr = [NSMutableArray array];
    }
    return _editArr;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[self.editArr addObject:_dataArr[indexPath.row]];
    remondModel *model = _dataArr[indexPath.row];
    [self.editArr addObject:model];
    
    NSLog(@"--------editArr is %@--------indexpath.row's model is %@---",_editArr,_dataArr[indexPath.row]);
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    remondModel *model = _dataArr[indexPath.row];
    [self.editArr removeObject:model];
    NSLog(@"--------editArr is %@--------indexpath.row's model is %@---",_editArr,_dataArr[indexPath.row]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
return     self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    remondTableViewCell *cell = [remondTableViewCell cellWithTableView:tableView];
    cell.model = [remondModel modalWithDict:_dataArr[indexPath.row]];
    return cell;

}
- (IBAction)addRemond:(id)sender {
    
    addRemondViewController *add = [[addRemondViewController alloc] init];
    add.ID = self.ID;
    [self.navigationController pushViewController:add animated:YES];
    
}
- (IBAction)deletAction:(id)sender {
    NSLog(@"_editArr is %@",_editArr);
   
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<self.editArr.count; i++) {
        remondModel *model = _editArr[i];
        [arr addObject:model.ID];
    
        [self.dataArr removeObject:_editArr[i]];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:arr forKey:@"CustomerRemindIDList"];
    [dic setObject:self.ID forKey:@"CustomerID"];
    [IWHttpTool WMpostWithURL:@"/Customer/DeleteCustomerRemindList" params:dic success:^(id json) {
        NSLog(@"删除客户提醒成功%@",json);
        for(NSDictionary *dic in  json[@"CustomerRemindList"]){
        
        }
    } failure:^(NSError *error) {
        NSLog(@"删除客户提醒请求失败%@",error);
    }];
    
    [self.table setEditing:NO animated:YES];
    [self.table reloadData];
}
@end
