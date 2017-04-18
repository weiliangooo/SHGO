//
//  CKMsgModel.m
//  SHGO
//
//  Created by Alen on 2017/3/24.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMsgModel.h"

@implementation CKMsgModel

-(instancetype)initWithInputData:(NSDictionary *)inputData
{
    if (self = [super init])
    {
        self.ckId = [inputData stringForKey:@"id"];
        self.ckIdType = [inputData stringForKey:@"id_type"];
        self.ckOwn = [inputData stringForKey:@"is_own"];
        self.ckMemId = [inputData stringForKey:@"member_id"];
        self.ckName = [inputData stringForKey:@"passenger_name"];
        self.ckNumber = [inputData stringForKey:@"passenger_number"];
        self.ckPhone = [inputData stringForKey:@"passenger_phone"];
        self.ckSex = [inputData stringForKey:@"passenger_sex"];
        self.ckType = [inputData stringForKey:@"passenger_type"];
    }
    return self;
}

@end
