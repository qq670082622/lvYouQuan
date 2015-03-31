//
//  remondViewController.m
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/31.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "remondViewController.h"
#import "addRemondViewController.h"
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
    [self loadData];
    [self setUpRightButton];
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
        self.navigationItem.rightBarButtonItem.title = @"取消";
    }else if (self.subView.hidden == YES){
        self.subView.hidden = NO;
        self.deleBtn.hidden = YES;
        [self.table setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    }
    
}

-(void)loadData
{
    for (int i = 0; i<10; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[NSString stringWithFormat:@"吃第%d次饭🍚",i+1] forKey:@"des"];
        [dic setValue:[NSString stringWithFormat:@"拉第%d次屎💩",i+1] forKey:@"time"];
        [self.dataArr addObject:dic];
    }
    
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
    [self.navigationController pushViewController:add animated:YES];
    
}
- (IBAction)deletAction:(id)sender {
    NSLog(@"_editArr is %@",_editArr);
    for (int i = 0; i<self.editArr.count; i++) {
        [self.dataArr removeObject:_editArr[i]];
    }
    [self.table setEditing:NO animated:YES];
    [self.table reloadData];
}
@end
