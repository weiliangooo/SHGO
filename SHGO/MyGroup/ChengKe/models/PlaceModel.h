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

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *detailAddress;
@property (nonatomic, assign) CLLocationCoordinate2D location;

-(NSString *)locationToString;
-(CLLocationCoordinate2D)stringToLocation:(NSString *)place;
@end
