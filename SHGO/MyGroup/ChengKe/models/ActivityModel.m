//
//  ActivityModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/18.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

-(instancetype)initWithInputData:(NSDictionary *)inputData
{
    if (self = [super init])
    {
        if (inputData == nil)
        {
            self.actId = @"无优惠";
            self.actName = @"不使用优惠券";
            self.actPrice = @"0";
            self.actType = @"0";
            self.endTime = @"无限期";
        }
        else
        {
            self.actId = [inputData stringForKey:@"act_id"];
            self.actName = [inputData stringForKey:@"name"];
            self.actPrice = [inputData stringForKey:@"price"];
            self.actType = [inputData stringForKey:@"type"];
            if ([self.actType isEqualToString:@"coupon"]) {
                self.endTime = [NSString stringWithFormat:@"有效期至%@", [MyHelperTool timeSpToTime:[inputData stringForKey:@"end_time"]]];
            }else{
                self.endTime = @"无限期";
            }
            
        }
    }
    return self;
}

@end
