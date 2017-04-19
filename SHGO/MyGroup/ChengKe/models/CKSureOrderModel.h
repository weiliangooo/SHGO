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
///留言
@property (nonatomic, strong) NSString *up_message;
///活动id
@property (nonatomic, strong) NSString *up_act_id;
///活动的type
@property (nonatomic, strong) NSString *up_type;
///出发的时间戳 format 2014-04-18 12:00
@property (nonatomic, strong) NSString *up_start_time;
///班次的id
@property (nonatomic, strong) NSString *up_banci_id;
///出发的坐标
@property (nonatomic, strong) NSString *up_start;
///出发的具体名称
@property (nonatomic, strong) NSString *up_start_name;
///到达地具体名称
@property (nonatomic, strong) NSString *up_arrive_name;
///到达地坐标 “lat，lon”
@property (nonatomic, strong) NSString *up_arriver;
///付款方式
@property (nonatomic, strong) NSString *up_paytype;
///1 微信。 2 支付宝
@property (nonatomic, strong) NSString *up_paytool;
///乘客信息 例：乘客id|乘客姓名|乘客类型_乘客id|乘客姓名|乘客类型
@property (nonatomic, strong) NSString *up_passenger;
///是否使用钱包 默认2。使用1
@property (nonatomic, strong) NSString *up_use_wallet;

@end
