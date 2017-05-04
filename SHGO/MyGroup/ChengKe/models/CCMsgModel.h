//
//  CCMsgModel.h
//  SHGO
//
//  Created by Alen on 2017/3/24.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CKMsgModel.h"
#import "PlaceModel.h"

@interface CCMsgModel : NSObject
///记录出发地点
@property (nonatomic, strong)PlaceModel *startPlaceModel;
///记录目的地点
@property (nonatomic, strong)PlaceModel *endPlaceModel;
//乘客数据
@property (nonatomic, strong)NSMutableArray <CKMsgModel *>* aboardPeople;

@end
