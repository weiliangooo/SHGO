//
//  MsgListModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/25.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "MsgListModel.h"

@implementation MsgListModel

-(instancetype)initWith:(NSArray *)dataSource
{
    if (self = [super init])
    {
        _msgModels = [NSMutableArray array];
        for (int i = 0; i < dataSource.count; i++)
        {
            MsgModel *model = [[MsgModel alloc] initWithData:dataSource[i]];
            [_msgModels addObject:model];
        }
    }
    return self;
}

@end

@implementation MsgModel

-(instancetype)initWithData:(NSDictionary *)dataSource
{
    if (self = [super init])
    {
        _msgId = [dataSource stringForKey:@"id"];
        _msgContent = [dataSource stringForKey:@"info_content"];
        _msgMemberId = [dataSource stringForKey:@"member_id"];
        _msgWebUrl = [dataSource stringForKey:@"wapurl"];
        _sendTime = [self timeWithTimeIntervalString:[dataSource stringForKey:@"send_time"]];
        if ([[dataSource stringForKey:@"member_id"] isEqualToString:@"1"])
        {
            _isRead = YES;
        }
        else
        {
            _isRead = NO;
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
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
