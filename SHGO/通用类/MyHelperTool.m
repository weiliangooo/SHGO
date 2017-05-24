//
//  MyHelperTool.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/4.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "MyHelperTool.h"

@implementation MyHelperTool

///CLLocationCoordinate2D -> “经度，纬度”
+(NSString *)locationCoordinateToLocationString:(CLLocationCoordinate2D)coordinate{
    NSString *latString = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *lonString = [NSString stringWithFormat:@"%f", coordinate.longitude];
    return [NSString stringWithFormat:@"%@,%@",[self changeFloat:latString] ,[self changeFloat:lonString]];
}

///“经度，纬度” -> CLLocationCoordinate2D
+(CLLocationCoordinate2D)locationStringToLocationCoordinate:(NSString *)locationString{
    NSArray *temp=[locationString componentsSeparatedByString:@","];
    return  CLLocationCoordinate2DMake([[temp objectAtIndex:0] doubleValue], [[temp objectAtIndex:1] doubleValue]);
}

///YYYY-MM-dd HH:mm:ss -> 时间戳
+(NSString *)normalTimeToTimeSP:(NSString *)normalTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:normalTime];
    return [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
}

///去除经纬度多余的0
+(NSString *)changeFloat:(NSString *)stringFloat{
    NSUInteger length = [stringFloat length];
    for(int i = 1; i<=10; i++){
        NSString *subString = [stringFloat substringFromIndex:length - i];
        if(![subString isEqualToString:@"0"]){
            return stringFloat;
        }else{
            stringFloat = [stringFloat substringToIndex:length - i];
        }
    }
    return [stringFloat substringToIndex:length - 7];
}

+ (BOOL)isLocationServiceOpen {
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}

+(BOOL)isNeedUpdate:(NSString *)newVersion{
    // 获取app版本
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    //剔除版本号字符串中的点
    newVersion = [newVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    app_Version = [app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    //计算版本号位数差
    int placeMistake = (int)(newVersion.length-app_Version.length);
    //根据placeMistake的绝对值判断两个版本号是否位数相等
    if (abs(placeMistake) == 0) {
        //位数相等
        return [newVersion integerValue] > [app_Version integerValue];
    }else {
        //位数不等
        //multipleMistake差的倍数
        NSInteger multipleMistake = pow(10, abs(placeMistake));
        NSInteger server = [newVersion integerValue];
        NSInteger local = [app_Version integerValue];
        if (server > local) {
            return server > local * multipleMistake;
        }else {
            return server * multipleMistake > local;
        }
    }
}

@end
