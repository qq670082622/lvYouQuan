//
//  UserInfo.h
//  ShouKeBao
//
//  Created by Chard on 15/3/23.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (UserInfo *)shareUser;

@property (nonatomic,copy) NSString *BusinessID;// 商家id

@property (nonatomic,copy) NSString *DistributionID;// 分销人id

+ (instancetype)userInfoWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
