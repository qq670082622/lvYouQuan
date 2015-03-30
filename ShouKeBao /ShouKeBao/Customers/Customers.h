//
//  Customers.h
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Customers : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *timeOderOutlet;
- (IBAction)timeOrderAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *orderNumOutlet;
- (IBAction)orderNumAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wordOrderOutlet;
- (IBAction)wordOrderAction:(id)sender;
- (IBAction)customSearch:(id)sender;


@end
