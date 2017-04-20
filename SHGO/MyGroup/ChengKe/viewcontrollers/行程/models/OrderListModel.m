//
//  OrderListModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/20.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

-(instancetype)initWithData:(NSMutableArray *)dataSource
{
    if ([super init])
    {
        for (int i = 0 ; i < dataSource.count; i++)
        {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[dataSource objectAtIndex:i]];
            OrderListMemModel *model = [[OrderListMemModel alloc] initWithData:dic];
            [self addObject:model];
        }
    }
    return self;
}

@end


@implementation OrderListMemModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if ([super init])
    {
        self.order_status = [dataSource stringForKey:@"order_status"];
        self.common_id = [dataSource stringForKey:@"common_id"];
        self.need_transfer = [dataSource stringForKey:@"need_transfer"];
        self.order_time = [dataSource stringForKey:@"order_time"];
        self.start_unixtime = [dataSource stringForKey:@"start_unixtime"];
        self.start_address_name = [dataSource stringForKey:@"start_address_name"];
        self.end_address_name = [dataSource stringForKey:@"end_address_name"];
        self.order_sn = [dataSource stringForKey:@"order_sn"];
        self.s_name = [dataSource stringForKey:@"s_name"];
        self.e_name = [dataSource stringForKey:@"e_name"];
        self.type = [dataSource stringForKey:@"type"];
    }
    return self;
}

@end
