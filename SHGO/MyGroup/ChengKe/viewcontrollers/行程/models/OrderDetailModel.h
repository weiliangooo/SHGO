//
//  OrderDetailModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceModel.h"


typedef enum : NSUInteger {
    OrderStatusWait,      ///等车中
    OrderStatusOnWay,     ///行程中
    OrderStatusFinish,    ///已完成
    OrderStatusClose,     ///已关闭
} OrderStatus;

@interface OrderDetailModel : NSObject

@property (nonatomic, strong) NSString *driverName;

@property (nonatomic, strong) NSString *driverPhone;

@property (nonatomic, strong) NSString *driverScore;

@property (nonatomic, strong) NSString *carCode;

@property (nonatomic, strong) NSString *carName;

@property (nonatomic, strong) NSMutableArray<NSString *> *ckNames;

@property (nonatomic, strong) NSString *orderPrice;

@property (nonatomic, strong) NSString *orderStatus;

@property (nonatomic, strong) PlaceModel *startPlace;

@property (nonatomic, strong) PlaceModel *endPlace;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end
