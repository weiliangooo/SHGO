//
//  CKSendOrderViewController.h
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMapViewController.h"

@class CKSureOrderModel;
@interface CKSendOrderViewController : CKMapViewController

@property (nonatomic, strong) CKSureOrderModel *dataSource;

@property (nonatomic, strong) NSString *startEndCity;

@property (nonatomic, strong) NSString *startTime; 

@property (nonatomic, strong) NSString *orderNum;

@end
