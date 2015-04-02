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
#import "RemindDetailViewController.h"
@interface remondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *dataArr;
- (IBAction)addRemond:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (strong,nonatomic) NSMutableArray *editArr;
- (IBAction)deletAction:(id)sender;

@property (nonatomic,assign) BOOL isEditing;

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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
-(void)setUpRightButton{

    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(EditCustomerDetail)];
    
    self.navigationItem.rightBarButtonItem= barItem;
}
-(void)EditCustomerDetail
{
    if (self.subView.hidden == NO && !self.isEditing) {
        self.subView.hidden = YES;
        self.deleBtn.hidden = NO;
        [self.table setEditing:YES animated:YES];
        self.isEditing = YES;

        
        self.navigationItem.rightBarButtonItem.title = @"取消";

    }else if (self.subView.hidden == YES && self.isEditing){
        self.subView.hidden = NO;
        self.deleBtn.hidden = YES;
        [self.table setEditing:NO animated:YES];
        self.isEditing = NO;

        
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    }
    
}

-(void)loadData
{

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.ID forKey:@"CustomerID"];
    [IWHttpTool WMpostWithURL:@"/Customer/GetCustomerRemindList" params:dic success:^(id json) {
        NSLog(@"提醒列表json is %@",json);
       // [self.dataArr removeAllObjects];
        for(NSDictionary *dic in json[@"CustomerRemindList"]){
            remondModel *model = [remondModel modalWithDict:dic];
            [self.dataArr addObject:model];
        }
        [self.table reloadData];
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
    
    remondModel *model = _dataArr[indexPath.row];
    if (self.table.editing == YES) {
       
        [self.editArr addObject:model];
      
    }else if (self.table.editing == NO){
        RemindDetailViewController *remondDetail = [[RemindDetailViewController alloc] init];
        remondDetail.time = model.RemindTime;
        remondDetail.note = model.Content;
        [self.navigationController pushViewController:remondDetail animated:YES];
    }
    
    
    NSLog(@"--------editArr is %@--------indexpath.row's model is %@---",_editArr,_dataArr[indexPath.row]);
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    remondModel *model = _dataArr[indexPath.row];
    if (self.table.editing == YES) {
        
    [self.editArr removeObject:model];
        
    }
   
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
    cell.model = _dataArr[indexPath.row];
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
    
    if (arr) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:arr forKey:@"CustomerRemindIDList"];
        [dic setObject:self.ID forKey:@"CustomerID"];
        [IWHttpTool WMpostWithURL:@"/Customer/DeleteCustomerRemindList" params:dic success:^(id json) {
            NSLog(@"删除客户提醒成功%@",json);
            [self.dataArr removeAllObjects];
            for(NSDictionary *dic in  json[@"CustomerRemindList"]){
                remondModel  *model = [remondModel modalWithDict:dic];
                [self.dataArr addObject:model];
            }
            [self.table reloadData];
            
        } failure:^(NSError *error) {
            NSLog(@"删除客户提醒请求失败%@",error);
        }];
        
        [self.table setEditing:NO animated:YES];
        [self.table reloadData];

    }else if (!arr){
    [self.table setEditing:NO animated:YES];
    }
    
    }
@end
