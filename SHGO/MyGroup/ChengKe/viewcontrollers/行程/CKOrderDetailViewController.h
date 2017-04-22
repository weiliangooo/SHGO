//
//  CKOrderDetailViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMapViewController.h"


@class OrderDetailModel;
@interface CKOrderDetailViewController : CKMapViewController

@property (nonatomic, strong) OrderDetailModel *dataSouce;

@property (nonatomic, strong) NSString *orderNum;

-(instancetype)initWithOrderDetailModel:(OrderDetailModel *)orderDetailModel;

@end
