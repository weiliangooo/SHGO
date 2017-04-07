//
//  CKSureOrderModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CKMsgModel.h"

@interface CKSureOrderModel : NSObject

///乘车出发城市
@property (nonatomic, strong) NSString *startCity;
///乘车到达城市
@property (nonatomic, strong) NSString *endCity;
///乘车的时间
@property (nonatomic, strong) NSString *ccTime;
///乘车成员信息
@property (nonatomic, strong) NSMutableArray <CKMsgModel *>* aboardPeople;
///乘车单价
@property (nonatomic, strong) NSString *singerPrice;
///单人接送附加费用
@property (nonatomic, strong) NSString *singerAddPrice;
///账户余额
@property (nonatomic, strong) NSString *accountPrice;



@end
