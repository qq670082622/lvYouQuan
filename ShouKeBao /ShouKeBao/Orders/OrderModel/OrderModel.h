//
//  OrderModel.h
//  ShouKeBao
//
//  Created by Chard on 15/3/24.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic,copy) NSString *orderNum;

@property (nonatomic,copy) NSString *orderDate;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *orderDescript;

@property (nonatomic,copy) NSString *orderGoDate;

@property (nonatomic,copy) NSString *orderPerson;

@property (nonatomic,copy) NSString *orderState;

@property (nonatomic,copy) NSString *orderPrice;

+ (instancetype)orderModelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
