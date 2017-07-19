//
//  BillHisModel.h
//  SHGO
//
//  Created by Alen on 2017/7/19.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillModel.h"

@interface BillHisModel : NSObject

@property (nonatomic, strong) NSString *fptt;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *recive_user;
@property (nonatomic, strong) NSString *recive_phone;
@property (nonatomic, strong) NSString *recive_address;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSMutableArray<BillModel *> *billModels;

-(instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
