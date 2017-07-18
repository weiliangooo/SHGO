//
//  BillModels.h
//  SHGO
//
//  Created by 魏亮 on 2017/7/18.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface BillModel : NSMutableArray
//
//-(void)arrayWithDataSource:(NSArray *)dataSource;
//
//@end

@interface BillModel : NSObject

@property (nonatomic, strong) NSString *common_id;
@property (nonatomic, strong) NSString *start_address_name;
@property (nonatomic, strong) NSString *start_name;
@property (nonatomic, strong) NSString *end_address_name;
@property (nonatomic, strong) NSString *arrive_name;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *order_time;

-(instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
