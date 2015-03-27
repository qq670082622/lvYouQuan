//
//  UIColor+SK.m
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/27.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "UIColor+SK.h"

@implementation UIColor (SK)

/*
 1 灰色 2蓝色 3橙色 4绿色 5红色 6紫色
 */
+ (UIColor *)configureColorWithNum:(NSInteger)num
{
    switch (num) {
        case 1:
            return [UIColor grayColor];
            break;
        case 2:
            return [UIColor blueColor];
            break;
        case 3:
            return [UIColor orangeColor];
            break;
        case 4:
            return [UIColor greenColor];
            break;
        case 5:
            return [UIColor redColor];
            break;
        case 6:
            return [UIColor purpleColor];
            break;
        default:
            return [UIColor grayColor];
            break;
    }
}

@end
