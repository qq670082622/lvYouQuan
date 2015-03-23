//
//  oderMoal.h
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface oderMoal : NSObject
@property (nonatomic,copy) NSString *orderNum;
@property (nonatomic,copy) NSString *orderDate;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *orderDescript;
@property (nonatomic,copy) NSString *orderGoDate;
@property (nonatomic,copy) NSString *orderPerson;
@property (nonatomic,copy) NSString *orderState;
@property (nonatomic,copy) NSString *orderPrice;
+ (instancetype)modalWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
