//
//  StationSelect.h
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/27.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol passStation<NSObject>
-(void)passStation:(NSString *)stationName andStationNum:(NSMutableString*)stationNum;
@end
@interface StationSelect : UIViewController
@property(weak,nonatomic)id<passStation>delegate;
@end
