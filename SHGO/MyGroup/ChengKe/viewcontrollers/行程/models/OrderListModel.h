//
//  OrderListModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/20.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>


@class OrderListMemModel;
@interface OrderListModel : NSMutableArray


-(instancetype)initWithData:(NSArray *)dataSource;

@end


@interface OrderListMemModel : NSObject

@property (nonatomic, strong) NSString * order_status;
@property (nonatomic, strong) NSString * common_id;
@property (nonatomic, strong) NSString * need_transfer;
@property (nonatomic, strong) NSString * order_time;
@property (nonatomic, strong) NSString * start_unixtime;
@property (nonatomic, strong) NSString * start_address_name;
@property (nonatomic, strong) NSString * end_address_name;
@property (nonatomic, strong) NSString * order_sn;
@property (nonatomic, strong) NSString * s_name;
@property (nonatomic, strong) NSString * e_name;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end



