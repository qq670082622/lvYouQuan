//
//  WriteFileManager.m
//  hishow
//
//  Created by Chard on 15/3/14.
//  Copyright (c) 2015年 haixun. All rights reserved.
//

#import "WriteFileManager.h"

@implementation WriteFileManager

+ (NSArray *)saveFileWithArray:(NSArray *)array Name:(NSString *)name
{
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    [array writeToFile:filePath atomically:YES];
    return array;
}

+ (NSArray *)readFielWithName:(NSString *)name
{
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    return data;
}

// 模型存储
+ (NSArray *)saveData:(NSArray *)array name:(NSString *)name
{

    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    
    return array;
}

+ (NSArray *)readData:(NSString *)name
{
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 拼接文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:name];
    
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
   
    return arr;
}

@end
