//
//  ConditionSelectViewController.m
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/25.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "ConditionSelectViewController.h"

@interface ConditionSelectViewController ()

@end

@implementation ConditionSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //self.dataArr1 = [self.conditionDic ]
}

-(NSArray *)dataArr1
{
    if (_dataArr1 == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        for(NSDictionary *dic in self.conditionDic){
            [arr addObject:dic];
            }
        _dataArr1 = arr;
    }
        return _dataArr1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, 60, 35)];
        label1.text = _dataArr1[indexPath.row][@"Text"];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 1, 60, 35)];
        label2.text = _dataArr1[indexPath.row][@"Value"];
       
        [cell.contentView addSubview:label1];
        [cell.contentView addSubview:label2];
        
    }
    
    return cell;
}

@end
