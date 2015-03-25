//
//  LoginTool.m
//  ShouKeBao
//
//  Created by Chard on 15/3/23.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "LoginTool.h"
#import "IWHttpTool.h"

@implementation LoginTool

/**
 *  请求登录
 */
+ (void)loginWithParam:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    [IWHttpTool postWithURL:@"Business/Login" params:param success:^(id json) {
        
        if (success) {
            success(json);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

/**
 *  获取验证码
 */
+ (void)getCodeWithParam:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    [IWHttpTool postWithURL:@"Business/Login" params:param success:^(id json) {
        
        if (success) {
            success(json);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
