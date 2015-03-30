//
//  CustomModel.h
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/30.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject
@property (nonatomic,copy) NSString *userIcon;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userTele;
@property (nonatomic,copy) NSString *userOrder;
+ (instancetype)modalWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
