//
//  Fram.m
//  benben
//
//  Created by xunao on 15-3-2.
//  Copyright (c) 2015年 xunao. All rights reserved.
//

#import "Frame.h"
#import "sys/utsname.h"

@implementation Frame

//处理sql语句中单引号
+(NSString *)checkSqlStr:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

+(NSString *)transformDisplayDate:(int)time
{
    if (time >= 0) {
        int nowtime = [[NSDate date] timeIntervalSince1970];
        int pasttime = nowtime - time;
        if (pasttime > 0) {
            int days = pasttime/(60*60*24);
            if (days > 0) {
                //大于一天
                return [NSString stringWithFormat:@"%d天前", days];
            }
            int hours = pasttime/(60*60);
            if (hours > 0) {
                return [NSString stringWithFormat:@"%d小时前", hours];
            }
            
            int mins = pasttime/60;
            if (mins > 0) {
                return [NSString stringWithFormat:@"%d分钟前", mins];
            }else {
                return @"刚刚";
            }
        }
        return @"刚刚";
    }
    return @"--";
}

+(NSString *)formatNumber:(int)number
{
    
    if (number <= 0) {
        return @"0";
    }
    NSString *result = @"";
    while (number > 0) {
        NSString *str = [Frame lastCountString:number];
        number = number/1000;
        if (number > 0) {
            result = [NSString stringWithFormat:@",%@%@", str, result];
        }else {
            result = [NSString stringWithFormat:@"%@%@", str, result];
        }
    }
    return result;
}
//取数字后三位
+(NSString *)lastCountString:(int)count
{
    NSMutableString *result = [NSMutableString string];
    int last = count%1000;
    int left = count/1000;
    if (left > 0) {
        [result appendFormat:@"%03d",last];
    }else {
        [result appendFormat:@"%i",last];
    }
    return result;
}


+(BOOL)deleteFileWithFullPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

+(NSString *)getLibraryFilePathWithFolder:(NSString *)folder fileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSString *gPath = [dir stringByAppendingPathComponent:folder];
    if (![[NSFileManager defaultManager] fileExistsAtPath:gPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:gPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [gPath stringByAppendingPathComponent:fileName];
}

+(NSString *)getDownloadPath:(NSString *)urlString
{
    NSString *fileName = [urlString lastPathComponent];
    
    NSString *dir = NSHomeDirectory();
    NSString *gPath = [dir stringByAppendingPathComponent:@"tmp/download_cache/"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:gPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:gPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [gPath stringByAppendingPathComponent:fileName];
}

+(BOOL)isFileExist:(NSString *)fullPath
{
    BOOL iexst = NO;
    if (fullPath != NULL && fullPath.length > 0) {
        iexst = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    }
    return iexst;
}

//正则匹配
+(BOOL)regularMatch:(NSString *)regex string:(NSString *)string
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

+(BOOL)isIdCard:(NSString *)number
{
    if ([NSString trimEmpty:number]) {
        return NO;
    }
    return [Frame regularMatch:@"^\\d{17}([0-9]|X|x)$" string:number];
}

@end
///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation NSUserDefaults (custom)

-(NSString *)hstringForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if (obj==[NSNull null] || obj==nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",obj];
}
@end

@implementation NSDictionary (custom)

-(id)objectForKeyCheckNull:(id)aKey
{
    id value = [self objectForKey:aKey];
    if ([value isEqual:[NSNull null]]) {
        return nil;
    }
    return value;
}

-(id)objectForKey:(id)aKey DefaultValue:(id)value
{
    id obj = [self objectForKey:aKey];
    if (obj==[NSNull null] || obj==nil) {
        return value;
    }
    return obj;
}

-(NSInteger)integerForKey:(id)aKey
{
    id value = [self objectForKeyCheckNull:aKey];
    return [value integerValue];
}

-(int)intForKey:(id)aKey
{
    id value = [self objectForKeyCheckNull:aKey];
    if (value) {
        return [value intValue];
    }
    return 0;
}

-(NSString *)stringForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if (obj==[NSNull null] || obj==nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",obj];
}

-(NSArray *)arrayForKey:(id)akey
{
    id value = [self objectForKeyCheckNull:akey];
    if (value && [value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return [NSArray array];
}
@end
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSString (custom)

+(NSString *)stringWithStringCheckNull:(NSString *)value
{
    if (value != nil && value.length > 0) {
        return [NSString stringWithString:value];
    }
    return @"";
}

+(NSString *)stringWithInt:(int)value
{
    return [NSString stringWithFormat:@"%i", value];
}

+(BOOL)trimEmpty:(NSString *)str
{
    NSString *trimStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return (trimStr == nil || trimStr.length <= 0);
}


-(NSString *)stringByReplacePathExtension:(NSString *)extensions
{
    if (self && self.length > 0) {
//        NSString *ext = [self pathExtension];
        NSString *newPath = [self stringByDeletingPathExtension];
        return [newPath stringByAppendingPathExtension:extensions];
    }
    return @"";
}

-(BOOL)isContainsEmoji
{
    __block BOOL isEomji = NO;
    
    if (self && self.length > 0) {
        
        [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
         
         ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
             
             const unichar hs = [substring characterAtIndex:0];
             
             // surrogate pair
             
             if (0xd800 <= hs && hs <= 0xdbff) {
                 
                 if (substring.length > 1) {
                     
                     const unichar ls = [substring characterAtIndex:1];
                     
                     const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                     
                     if (0x1d000 <= uc && uc <= 0x1f77f) {
                         
                         isEomji = YES;
                         
                     }
                     
                 }
                 
             } else if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 if (ls == 0x20e3 || ls == 0xfe0f) {
                     
                     isEomji = YES;
                     
                 }
                 
             } else {
                 
                 // non surrogate
                 
                 if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                     
                     isEomji = YES;
                     
                 } else if (0x2B05 <= hs && hs <= 0x2b07) {
                     
                     isEomji = YES;
                     
                 } else if (0x2934 <= hs && hs <= 0x2935) {
                     
                     isEomji = YES;
                     
                 } else if (0x3297 <= hs && hs <= 0x3299) {
                     
                     isEomji = YES;
                     
                 } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         }];

    }
    
    return isEomji;

}

-(int)chineseLength
{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}


@end


///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIDevice (ALSystemVersion)

+ (float)iOSVersion {
    static float version = 0.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return version;
}

+(NSString *)deviceModel
{
    //here use sys/utsname.h
    struct utsname systemInfo;
    //声明结构体，包含5个char数成员:sysname,nodename,release,version,machine
    uname(&systemInfo);
    //c方法，填写系统结构体内容，返回值为0，表示成功。
    //get the device model and the system version
    
//    NSLog(@"%@", [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIImage (CustomExtend)

+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}


+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+(UIImage*)imageWithUIView:(UIView*) view
{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)scaleImage:(UIImage *)img ToSizesize:(CGSize)size
{
    if (img != nil) {
        CGSize imageSize = img.size;
        CGFloat scale = MIN(size.width/imageSize.width, size.height/imageSize.height);
        CGSize targetSize = CGSizeMake(imageSize.width*scale, imageSize.height*scale);
        
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(targetSize);
        // 绘制改变大小的图片
        [img drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return scaledImage;
    }
    return img;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIView (custom)

-(void)removeAllSubviews
{
    while ([self.subviews count] > 0) {
        [[self.subviews objectAtIndex:0] removeFromSuperview];
    }
}

@end
