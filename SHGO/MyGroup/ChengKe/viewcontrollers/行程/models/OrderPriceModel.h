//
//  OrderPriceModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderPriceModel : NSObject

@property (nonatomic, strong) NSString *need_price;
@property (nonatomic, strong) NSString *base_price;
@property (nonatomic, strong) NSString *added_price;
@property (nonatomic, strong) NSString *user_wallet;
@property (nonatomic, strong) NSString *discountName;
@property (nonatomic, strong) NSString *discountPrice;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end
