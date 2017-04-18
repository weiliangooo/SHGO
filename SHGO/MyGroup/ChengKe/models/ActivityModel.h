//
//  ActivityModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/18.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic, strong)NSString *actId;
@property (nonatomic, strong)NSString *actName;
///type=event or extra 每个人都优惠。  0:不优惠。  其他都是总价减
@property (nonatomic, strong)NSString *actPrice;
@property (nonatomic, strong)NSString *actType;

-(instancetype)initWithInputData:(NSDictionary *)inputData;

@end
