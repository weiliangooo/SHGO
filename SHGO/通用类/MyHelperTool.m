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


@end
