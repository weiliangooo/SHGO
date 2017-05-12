//
//  WalletMoneyModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletMoneyModel.h"

@implementation WalletMoneyModel

-(instancetype)initWithData:(NSArray *)dataSource
{
    if (self = [super init])
    {
        _listModels = [NSMutableArray array];
        for (int i = 0 ; i < dataSource.count; i++)
        {
            WalletMoneyListModel *model = [[WalletMoneyListModel alloc] initWithData:dataSource[i]];
            [_listModels addObject:model];
        }
    }
    return self;
}


@end

@implementation WalletMoneyListModel

-(instancetype)initWithData:(NSArray *)dataSource
{
    if (self = [super init])
    {
        _money = [NSString stringWithFormat:@"%@元", dataSource[0]];
        _time = dataSource[1];
        _type = dataSource[2];
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
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
