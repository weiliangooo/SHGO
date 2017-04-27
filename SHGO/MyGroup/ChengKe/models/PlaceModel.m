//
//  PlaceModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/20.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel


-(NSString *)locationToString
{
    return [NSString stringWithFormat:@"%f,%f",self.location.latitude,self.location.longitude];
}

-(CLLocationCoordinate2D)stringToLocation:(NSString *)place
{
    NSArray *temp=[place componentsSeparatedByString:@","];
    return  CLLocationCoordinate2DMake([[temp objectAtIndex:0] doubleValue], [[temp objectAtIndex:1] doubleValue]);
}


@end
