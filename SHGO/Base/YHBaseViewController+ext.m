//
//  YHBaseViewController+ext.m
//  RentOutProject
//
//  Created by D6G on 16/7/28.
//  Copyright © 2016年 Abel. All rights reserved.
//

#import "YHBaseViewController+ext.h"
#import "AppDelegate.h"

@implementation YHBaseViewController (ext)


//根据字体的大小和文字 计算所需的尺寸
-(CGSize)currentText:(NSString *)text textFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size;
}



@end
