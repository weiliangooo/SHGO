//
//  BillModels.m
//  SHGO
//
//  Created by 魏亮 on 2017/7/18.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "BillModel.h"

//@implementation BillModel
//
//-(void)arrayWithDataSource:(NSArray *)dataSource{
//    for (int i = 0; i < dataSource.count; i++) {
//        BillModel *model = [[BillModel alloc] initWithDataSource:dataSource[i]];
//        [self addObject:model];
//    }
//}
//
//@end

@implementation BillModel

-(instancetype)initWithDataSource:(NSDictionary *)dataSource{
    if (self = [super init]) {
        self.common_id = [dataSource stringForKey:@"common_id"];
        self.start_address_name = [dataSource stringForKey:@"start_address_name"];
        self.start_name = [dataSource stringForKey:@"start_name"];
        self.end_address_name = [dataSource stringForKey:@"end_address_name"];
        self.arrive_name = [dataSource stringForKey:@"arrive_name"];
        self.money = [dataSource stringForKey:@"money"];
        self.order_time = [dataSource stringForKey:@"order_time"];
    }
    return self;
}

@end
