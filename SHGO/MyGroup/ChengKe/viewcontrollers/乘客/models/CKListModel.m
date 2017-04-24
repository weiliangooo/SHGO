//
//  CKListModel.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/24.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKListModel.h"

@implementation CKListModel

-(instancetype)initWithData:(NSArray *)dataSoure
{
    if (self = [super init])
    {
        _ckListModels = [NSMutableArray array];
        for (int i = 0; i < dataSoure.count; i++)
        {
            NSDictionary *dic = dataSoure[i];
            CKListSingelModel *model = [[CKListSingelModel alloc] initWithData:dic];
            [_ckListModels addObject:model];
        }
    }
    return self;
}

@end


@implementation CKListSingelModel

-(instancetype)initWithData:(NSDictionary *)dataSoure
{
    if (self = [super init])
    {
        _ckId = [dataSoure stringForKey:@"id"];
        _ckName = [dataSoure stringForKey:@"passenger_name"];
        _ckNumber = [dataSoure stringForKey:@"passenger_number"];
        _ckPhone = [dataSoure stringForKey:@"passenger_phone"];
    }
    return self;
}

@end
