//
//  WalletMoneyModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WalletMoneyListModel;

@interface WalletMoneyModel : NSObject

@property (nonatomic, strong) NSString *allMoney;

@property (nonatomic, strong) NSMutableArray <WalletMoneyListModel *> *listModels;

-(instancetype)initWithData:(NSArray *)dataSource;

@end


@interface WalletMoneyListModel : NSObject

@property (nonatomic, strong) NSString *money;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *type;

-(instancetype)initWithData:(NSArray *)dataSource;

@end
