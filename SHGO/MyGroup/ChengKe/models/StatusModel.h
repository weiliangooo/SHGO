//
//  StatusModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/6/15.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusModel : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *car_cp;
@property (nonatomic, strong) NSString *car_id;
@property (nonatomic, strong) NSString *common_id;
@property (nonatomic, strong) NSString *driver_id;
@property (nonatomic, strong) NSString *driver_name;
@property (nonatomic, strong) NSString *driver_phone;
@property (nonatomic, strong) NSString *e;
@property (nonatomic, strong) NSString *ee;
@property (nonatomic, strong) NSString *end_address_name;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *myId;
@property (nonatomic, strong) NSString *local;
@property (nonatomic, strong) NSString *order_sn;
@property (nonatomic, strong) NSString *order_status;
@property (nonatomic, strong) NSString *order_time;
@property (nonatomic, strong) NSString *passenger_name;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *se;
@property (nonatomic, strong) NSString *start_address_name;
@property (nonatomic, strong) NSString *start_unixtime;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *car_type;
@property (nonatomic, strong) NSString *count;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end
