//
//  UIImage+ScalImage.h
//  LKHealthManagerEnterprise
//
//  Created by AaronLee on 14-8-8.
//  Copyright (c) 2014年 com.XINZONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScalImage)

/*
 * Tip：压缩图片至size大小
 */
- (UIImage*)scaleToSize:(CGSize)size;
/*
 * Tip：压缩图片根据高度
 */
-(UIImage *)scaleImageByWidth:(CGFloat)width;
/*
 * Tip：压缩图片根据宽度
 */
-(UIImage *)scaleImageByHeight:(CGFloat)height;
/*
 * Tip：旋转图片
 */

- (UIImage *)rotation:(UIImageOrientation)orientation;

@end
