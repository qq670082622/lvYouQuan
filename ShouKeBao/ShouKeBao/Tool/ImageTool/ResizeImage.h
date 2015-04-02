//
//  ResizeImage.h
//  ShouKeBao
//
//  Created by David on 15/3/17.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResizeImage : UIImage
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
@end
