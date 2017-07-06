//
//  StatusModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/15.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModel

-(instancetype)initWithData:(NSDictionary *)dataSource{
    if (self = [super init]) {
        self.avatar = [dataSource stringForKey:@"avatar"];
        self.car_cp = [dataSource stringForKey:@"car_cp"];
        self.car_id = [dataSource stringForKey:@"car_id"];
        self.common_id = [dataSource stringForKey:@"common_id"];
        self.driver_id = [dataSource stringForKey:@"driver_id"];
        self.driver_name = [dataSource stringForKey:@"driver_name"];
        self.driver_phone = [dataSource stringForKey:@"driver_phone"];
        self.e = [dataSource stringForKey:@"e"];
        self.ee = [dataSource stringForKey:@"ee"];
        self.end_address_name = [dataSource stringForKey:@"end_address_name"];
        self.flag = [dataSource stringForKey:@"flag"];
        self.myId = [dataSource stringForKey:@"id"];
        self.local = [dataSource stringForKey:@"local"];
        self.order_sn = [dataSource stringForKey:@"order_sn"];
        self.order_status = [dataSource stringForKey:@"order_status"];
        self.order_time = [dataSource stringForKey:@"order_time"];
        self.passenger_name = [dataSource stringForKey:@"passenger_name"];
        self.s = [dataSource stringForKey:@"s"];
        self.se = [dataSource stringForKey:@"se"];
        self.start_address_name = [dataSource stringForKey:@"start_address_name"];
        self.start_unixtime = [dataSource stringForKey:@"start_unixtime"];
        self.score = [dataSource stringForKey:@"score"];
        self.car_type = [dataSource stringForKey:@"car_type"];
        self.count = [dataSource stringForKey:@"count"];
    }
    return self;
}

@end
