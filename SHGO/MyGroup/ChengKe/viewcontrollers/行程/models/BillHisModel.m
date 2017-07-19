//
//  BillHisModel.m
//  SHGO
//
//  Created by Alen on 2017/7/19.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "BillHisModel.h"

@implementation BillHisModel

-(instancetype)initWithDataSource:(NSDictionary *)dataSource{
    if (self = [super init]) {
        self.fptt = [dataSource stringForKey:@"fptt"];
        self.money = [dataSource stringForKey:@"money"];
        self.recive_user = [dataSource stringForKey:@"recive_user"];
        self.recive_phone = [dataSource stringForKey:@"recive_phone"];
        self.recive_address = [dataSource stringForKey:@"recive_address"];
        self.add_time = [dataSource stringForKey:@"add_time"];
        
        self.billModels = [NSMutableArray array];
        NSArray *array = [dataSource arrayForKey:@"child"];
        for (int i = 0; i < array.count; i++) {
            BillModel *model = [[BillModel alloc] initWithDataSource:array[i]];
            [self.billModels addObject:model];
        }
    }
    return self;
}

@end
