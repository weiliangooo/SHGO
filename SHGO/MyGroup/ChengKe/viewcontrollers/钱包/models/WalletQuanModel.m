//
//  WalletQuanModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/25.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletQuanModel.h"

@implementation WalletQuanModel

-(instancetype)initWithData:(NSArray *)dataSource
{
    if (self = [super init])
    {
        _listModels = [NSMutableArray array];
        for (int i = 0 ; i < dataSource.count; i++)
        {
            WalletQuanListModel *model = [[WalletQuanListModel alloc] initWithData:dataSource[i]];
            [_listModels addObject:model];
        }
    }
    return self;
}

@end


@implementation WalletQuanListModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        NSString *color1;
        NSString *color2;
        if ([[dataSource stringForKey:@"can_use"] isEqualToString:@"1"])
        {
            color1 = @"#19af17";
            color2 = @"#999999";
        }
        else
        {
            color1 = @"#f4f4f4";
            color2 = @"#f4f4f4";
            
        }
        _price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@.00", [dataSource stringForKey:@"coupon_price"]]];
        [_price addAttribute:NSFontAttributeName
                              value:SYSF750(20)
                              range:NSMakeRange(0, 1)];
        [_price addAttribute:NSFontAttributeName
                       value:SYSF750(60)
                       range:NSMakeRange(1, _price.length-1)];
        [_price addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:color1]
                       range:NSMakeRange(0, _price.length)];
        
        _title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"优惠券（%@）",[dataSource stringForKey:@"type"]]];
        [_title addAttribute:NSFontAttributeName
                       value:SYSF750(40)
                       range:NSMakeRange(0, 3)];
        [_title addAttribute:NSFontAttributeName
                       value:SYSF750(20)
                       range:NSMakeRange(3, _title.length-3)];
        [_title addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:color1]
                       range:NSMakeRange(0, _title.length)];
        
        _end_time = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"有效期至%@", [self timeWithTimeIntervalString:[dataSource stringForKey:@"end_time"]]]];
        [_end_time addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:color2]
                       range:NSMakeRange(0, _end_time.length)];
        
        if ([[dataSource stringForKey:@"is_all"] isEqualToString:@"1"])
        {
            _city = [[NSMutableAttributedString alloc] initWithString:@""];
        }
        else
        {
            _city = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@——%@",[dataSource stringForKey:@"b_address"],[dataSource stringForKey:@"e_address"]]];
            [_city addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:color2]
                          range:NSMakeRange(0, _city.length)];
        }
    }
    return self;
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


@end
