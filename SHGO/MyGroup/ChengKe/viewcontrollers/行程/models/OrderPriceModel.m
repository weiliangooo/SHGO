//
//  OrderPriceModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderPriceModel.h"

@implementation OrderPriceModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _need_price = [NSString stringWithFormat:@"%@元",[dataSource stringForKey:@"need_price"]];
        _base_price = [NSString stringWithFormat:@"%@元",[dataSource stringForKey:@"base_price"]];
        _added_price = [NSString stringWithFormat:@"%@元",[dataSource stringForKey:@"added_price"]];
        _user_wallet = [NSString stringWithFormat:@"%@元",[dataSource stringForKey:@"user_wallet"]];
        NSArray *array = [NSArray arrayWithArray:[dataSource arrayForKey:@"act"]];
        if (array.count == 0)
        {
            _discountName = @"无优惠";
            _discountPrice = @"";
        }
        else
        {
            _discountName = array[0];
            _discountPrice = [NSString stringWithFormat:@"%@元",array[1]];
        }
    }
    return self;
}

@end
