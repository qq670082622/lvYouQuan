//
//  ProductModal.h
//  ShouKeBao
//
//  Created by David on 15/3/17.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModal : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *descript;
@property (nonatomic, copy) NSString *productNum;
@property (nonatomic, copy) NSString *normalPrice;
@property (nonatomic, copy) NSString *cheapPrice;
@property (nonatomic, copy) NSString *profits;
@property (nonatomic, copy) NSString *jiafanValue;
@property (nonatomic, copy) NSString *quanValue;
@property (nonatomic, copy) NSString *setUpPlace;
//另外还有 是否返，券，闪电



+ (instancetype)modalWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
