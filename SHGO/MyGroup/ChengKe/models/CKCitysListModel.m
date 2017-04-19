//
//  CKCitysListModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/3/31.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKCitysListModel.h"

@implementation CKCitysListModel

-(instancetype)initWithData:(NSArray *)dataSource
{
    if (self = [super init])
    {
        _citysModel = [NSMutableArray array];
        for (int i = 0; i < dataSource.count; i++)
        {
            CKCitysModel *model = [[CKCitysModel alloc] initWithData:[dataSource objectAtIndex:i]];
            [_citysModel addObject:model];
        }
    }
    return self;
}

@end

@implementation CKCitysModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _cityName = [dataSource stringForKey:@"name"];
        _cityId = [dataSource stringForKey:@"id"];
        _placeModel = [NSMutableArray array];
        for (id objc in [dataSource arrayForKey:@"hotplace"])
        {
            CKHotPlaceModel *model = [[CKHotPlaceModel alloc] initWithData:objc];
            [_placeModel addObject:model];
        }
        
    }
    return self;
}

@end


@implementation CKHotPlaceModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _local = [dataSource stringForKey:@"local"];
        _place_name = [dataSource stringForKey:@"place_name"];
        _place_address = [dataSource stringForKey:@"place_address"];
    }
    return self;
}

@end
