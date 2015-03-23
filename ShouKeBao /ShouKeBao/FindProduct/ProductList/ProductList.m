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
@interface ProductList ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *setUpView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NSArray *dataArr;
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
    
    
    }
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

-(NSArray *)dataArr
{
    if (_dataArr == nil) {
        
    }

    return _dataArr;
   
}
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
