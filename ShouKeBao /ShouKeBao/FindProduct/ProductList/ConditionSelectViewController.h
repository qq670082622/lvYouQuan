//
//  ConditionSelectViewController.h
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/25.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(copy , nonatomic) NSString *title;
@property (strong , nonatomic) NSArray *dataArr;
@end
