//
//  WriteFileManager.h
//  hishow
//
//  Created by Chard on 15/3/14.
//  Copyright (c) 2015年 haixun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WriteFileManager : NSObject

// plist存储
+ (NSArray *)saveFileWithArray:(NSArray *)array Name:(NSString *)name;

+ (NSArray *)readFielWithName:(NSString *)name;

// 模型存储
+ (NSArray *)saveData:(NSArray *)array name:(NSString *)name;

+ (NSArray *)readData:(NSString *)name;

@end
