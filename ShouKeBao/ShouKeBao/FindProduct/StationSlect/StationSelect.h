//
//  StationSelect.h
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/27.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol notifi<NSObject>
-(void)notifiToReloadData;
@end
@interface StationSelect : UIViewController
@property (weak,nonatomic) id<notifi>delegate;
@end
