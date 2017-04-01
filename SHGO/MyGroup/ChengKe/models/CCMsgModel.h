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

@interface CCMsgModel : NSObject

@property (nonatomic, strong)NSString *startCity;

@property (nonatomic, strong)NSString *startAddress;

@property (nonatomic, strong)NSString *startDetailAddress;

@property (nonatomic, assign)CLLocationCoordinate2D startLocation;

@property (nonatomic, strong)NSString *endCity;

@property (nonatomic, strong)NSString *endAddress;

@property (nonatomic, strong)NSString *endDetailAddress;

@property (nonatomic, assign)CLLocationCoordinate2D endLocation;

@property (nonatomic, strong)NSString *aboardTime;

@property (nonatomic, strong)NSMutableArray <CKMsgModel *>* aboardPeople;

@end
