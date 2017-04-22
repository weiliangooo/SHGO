//
//  OrderPriceDetailViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@class OrderPriceModel;
@interface OrderPriceDetailViewController : YHBaseViewController

@property (nonatomic, strong) OrderPriceModel *orderPriceModel;

-(instancetype)initWithOrderPriceModel:(OrderPriceModel *)model;

@end
