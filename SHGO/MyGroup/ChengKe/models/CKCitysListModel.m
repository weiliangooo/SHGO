//
//  CKCitysListModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/3/31.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKCitysListModel.h"

@implementation CKCitysListModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _citysModel = [NSMutableArray array];
        [dataSource enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSLog(@"key = %@ and obj = %@", key, obj);
            CKCitysModel *model = [[CKCitysModel alloc] initWithData:[dataSource objectForKey:key]];
            [_citysModel addObject:model];
        }];
//        for (int i = 0; i < dataSource.count; i++)
//        {
//            
//            CKCitysModel *model = [CKCitysModel alloc] initWithData:<#(id)#>
//        }
    }
    return self;
}

@end

@implementation CKCitysModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _cityName = [[dataSource objectForKey:@"city"] stringForKey:@"name"];
        _cityModel = [[CKCityModel alloc] initWithData:[dataSource objectForKey:@"city"]];
        
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



@implementation CKCityModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _myId = [dataSource stringForKey:@"id"];
        _name = [dataSource stringForKey:@"name"];
        _local = [dataSource stringForKey:@"local"];
        _is_use = [dataSource stringForKey:@"is_use"];
        _distance = [dataSource stringForKey:@"distance"];
    }
    return self;
}

@end

@implementation CKHotPlaceModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _myId = [dataSource stringForKey:@"id"];
        _arean_id = [dataSource stringForKey:@"arean_id"];
        _local = [dataSource stringForKey:@"local"];
        _place_name = [dataSource stringForKey:@"place_name"];
        _place_address = [dataSource stringForKey:@"place_address"];
        _price = [dataSource stringForKey:@"price"];
    }
    return self;
}

@end
