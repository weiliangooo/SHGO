//
//  Fram.h
//  benben
//
//  Created by xunao on 15-3-2.
//  Copyright (c) 2015年 xunao. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Frame : NSObject

//处理sql语句中单引号
+(NSString *)checkSqlStr:(NSString *)str;
//时间戳转换成xx前
+(NSString *)transformDisplayDate:(int)time;
//数字添加逗号分隔符
+(NSString *)formatNumber:(int)number;
//删除文件
+(BOOL)deleteFileWithFullPath:(NSString *)filePath;
//获取下载地址
+(NSString *)getDownloadPath:(NSString *)urlString;
//文件是否存在
+(BOOL)isFileExist:(NSString *)fullPath;
//获取Library下路径
+(NSString *)getLibraryFilePathWithFolder:(NSString *)folder fileName:(NSString *)fileName;
//正则匹配
+(BOOL)regularMatch:(NSString *)regex string:(NSString *)string;
//身份证
+(BOOL)isIdCard:(NSString *)number;
@end


@interface NSDictionary (custom)
-(id)objectForKeyCheckNull:(id)aKey;
-(id)objectForKey:(id)aKey DefaultValue:(id)value;
-(NSInteger)integerForKey:(id)aKey;
-(int)intForKey:(id)aKey;
-(NSString *)stringForKey:(id)aKey;
-(NSArray *)arrayForKey:(id)akey;

@end

@interface NSString (custom)
+(NSString *)stringWithStringCheckNull:(NSString *)value;
+(NSString *)stringWithInt:(int)value;
+(BOOL)trimEmpty:(NSString *)str;
-(NSString *)stringByReplacePathExtension:(NSString *)extensions;
//是否包含Emoji表情
-(BOOL)isContainsEmoji;
//中英混合文字长度
-(int)chineseLength;
@end


//@interface UIDevice (ALSystemVersion)
//+ (float)iOSVersion;
//+(NSString *)deviceModel;
//@end
//
//
//@interface UIImage (CustomExtend)
//
////+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
//
////+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
//
/////UIView转成UIImage
//+(UIImage*)imageWithUIView:(UIView*) view;
//
/////图片等比例缩小到指定的最小尺寸
//+ (UIImage *)scaleImage:(UIImage *)img ToSizesize:(CGSize)size;

//@end


//@interface UIView (custom)
//-(void)removeAllSubviews;
//@end






