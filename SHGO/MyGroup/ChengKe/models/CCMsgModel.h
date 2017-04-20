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

@property (nonatomic, strong)PlaceModel *startPlaceModel;

@property (nonatomic, strong)PlaceModel *endPlaceModel;

@property (nonatomic, strong)NSString *aboardTime;

@property (nonatomic, strong)NSMutableArray <CKMsgModel *>* aboardPeople;

@end
