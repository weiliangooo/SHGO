//
//  OrderDetailModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _driverName = [dataSource stringForKey:@"d_name"];
        _driverPhone = [dataSource stringForKey:@"car_phone"];
        _driverScore = [dataSource stringForKey:@"car_score"];
        _carCode = [dataSource stringForKey:@"car_cp"];
        _carName = [dataSource stringForKey:@"car_name"];
        _orderPrice = [dataSource stringForKey:@"price"];
        _orderStatus = [dataSource stringForKey:@"status"];
        _startTime = [dataSource stringForKey:@"start_unixtime"];
        _is_pj = [dataSource stringForKey:@"is_pj"];
        
        PlaceModel *start = [[PlaceModel alloc] init];
        start.address = [dataSource stringForKey:@"start_name"];
        start.location = [MyHelperTool locationStringToLocationCoordinate:[dataSource stringForKey:@"start_local"]];
        _startPlace = start;
        
        PlaceModel *end = [[PlaceModel alloc] init];
        end.address = [dataSource stringForKey:@"end_name"];
        end.location = [MyHelperTool locationStringToLocationCoordinate:[dataSource stringForKey:@"end_local"]];
        _endPlace = end;
        
        NSArray *array = [dataSource arrayForKey:@"info"];
        _ckMsgs = [NSMutableArray array];
        for (int i = 0; i < array.count; i++){
            ckModel *model = [[ckModel alloc] initWithData:array[i]];
            [_ckMsgs addObject:model];
        }
    }
    return self;
}


@end


@implementation ckModel

-(instancetype)initWithData:(NSDictionary *)dataSource{
    if (self = [super init]) {
        _name = [dataSource stringForKey:@"name"];
        _orderId = [dataSource stringForKey:@"order_id"];
        _orderStatus = [dataSource stringForKey:@"order_status"];
        _orderStatus_ = [dataSource stringForKey:@"status"];
    }
    return self;
}


@end









