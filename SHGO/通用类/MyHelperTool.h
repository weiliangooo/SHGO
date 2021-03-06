//
//  MyHelperTool.h
//  SHGO
//
//  Created by 魏亮 on 2017/5/4.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyHelperTool : NSObject

///CLLocationCoordinate2D -> “经度，纬度”
+(NSString *)locationCoordinateToLocationString:(CLLocationCoordinate2D)coordinate;
///“经度，纬度” -> CLLocationCoordinate2D
+(CLLocationCoordinate2D)locationStringToLocationCoordinate:(NSString *)locationString;
///YYYY-MM-dd HH:mm:ss -> 时间戳
+(NSString *)normalTimeToTimeSP:(NSString *)normalTime;
///时间戳 -> YYYY-MM-dd HH:mm:ss
+(NSString *)timeSpToTime:(NSString *)timeSp;
///判断定位是否打开
+ (BOOL)isLocationServiceOpen;
///是否需要更新
+(BOOL)isNeedUpdate:(NSString *)newVersion;

@end
