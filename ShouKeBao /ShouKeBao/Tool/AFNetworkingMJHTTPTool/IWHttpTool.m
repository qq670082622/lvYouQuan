//
//  IWHttpTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWHttpTool.h"
#import "AFNetworking.h"
#import "StrToDic.h"

@implementation IWHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
   //组dic
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSString *mobileID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    //ClientSource 0其他，无需
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:@1 forKey:@"MobileType"];
    [tmp setObject:currentVersion forKey:@"MobileVersion"];
    [tmp setObject:mobileID forKey:@"MobileID"];
    [tmp addEntriesFromDictionary:params];
    
    NSString *normalURL = kWebServiceHost;
    
    NSString *new = [StrToDic jsonStringWithDicL:tmp];
    
        //NSLog(@"~~~~~~~string is :%@",new);
    // 2.发送请求
    NSString *overStr = [normalURL stringByAppendingString:url];
   
    [mgr POST:overStr parameters:new
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+ (void)WMpostWithURL:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    //设置URL
     NSString *normalURL = @"http://app200.lvyouquan.cn";
     NSString *overStr = [normalURL stringByAppendingString:url];
    NSURL *httpUrl = [[NSURL alloc] initWithString:overStr];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:httpUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:12.0f];
   //设置httpbody
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSString *mobileID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [params setObject:@1 forKey:@"MobileType"];
    [params setObject:currentVersion forKey:@"MobileVersion"];
    [params setObject:mobileID forKey:@"MobileID"];
    NSString *json = [StrToDic jsonStringWithDicL:params];
    urlRequest.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
    [urlRequest setHTTPMethod:@"POST"];
    //请求
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if ([data length] > 0 && connectionError == nil) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"~~~~~~~dic is %@",result);
    if (!connectionError) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            //NSLog(@"~~~~~~~dic is %@",result);
            
            if(success){
                success(result);
            }
            
        }else{
            if (failure) {
                failure(connectionError);
            }
        }
        
        
        }];
    
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        for (IWFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}


@end

/**
 *  用来封装文件数据的模型
 */
@implementation IWFormData

@end
