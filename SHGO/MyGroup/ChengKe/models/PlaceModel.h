//
//  PlaceModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/20.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PlaceModel : NSObject
///城市名称
@property (nonatomic, strong) NSString *cityName;
///大致地址
@property (nonatomic, strong) NSString *address;
///详细地址
@property (nonatomic, strong) NSString *detailAddress;
///地址经纬度
@property (nonatomic, assign) CLLocationCoordinate2D location;


//-(NSString *)locationToString;
//-(CLLocationCoordinate2D)stringToLocation:(NSString *)place;
@end
