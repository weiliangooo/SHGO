//
//  CKCitysListModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/3/31.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CKCitysModel;
@class CKCityModel;
@class CKHotPlaceModel;
@interface CKCitysListModel : NSObject


@property (nonatomic, strong)NSMutableArray <CKCitysModel *> *citysModel;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end


@interface CKCitysModel : NSObject

@property (nonatomic, strong)NSString *cityName;
@property (nonatomic, strong)CKCityModel *cityModel;
@property (nonatomic, strong)NSMutableArray <CKHotPlaceModel *> *placeModel;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end


@interface CKCityModel : NSObject

@property (nonatomic, strong) NSString *myId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *local;
@property (nonatomic, strong) NSString *is_use;
@property (nonatomic, strong) NSString *distance;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end

@interface CKHotPlaceModel : NSObject

@property (nonatomic, strong) NSString *myId;
@property (nonatomic, strong) NSString *arean_id;
@property (nonatomic, strong) NSString *local;
@property (nonatomic, strong) NSString *place_name;
@property (nonatomic, strong) NSString *place_address;
@property (nonatomic, strong) NSString *price;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end


