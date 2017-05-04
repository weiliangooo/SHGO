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
    return [NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude];
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


@end
