//
//  CustomerDetailViewController.h
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/30.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"
@class CustomModel;
@interface CustomerDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *weChat;
@property (weak, nonatomic) IBOutlet UITextField *QQ;
@property (weak, nonatomic) IBOutlet UITextView *note;
@property (nonatomic,copy) NSMutableString *ID;
@property (nonatomic,strong)CustomModel *model;
- (IBAction)remond:(id)sender;
- (IBAction)deleteCustomer:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tele;

@end
