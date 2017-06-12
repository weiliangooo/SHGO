//
//  WalletQuanModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/25.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WalletQuanListModel;

@interface WalletQuanModel : NSObject

@property (nonatomic, strong) NSMutableArray <WalletQuanListModel *> *listModels;

-(instancetype)initWithData:(NSArray *)dataSource;

@end

@interface WalletQuanListModel : NSObject

@property (nonatomic, strong) NSMutableAttributedString *price;

@property (nonatomic, strong) NSMutableAttributedString *title;

@property (nonatomic, strong) NSMutableAttributedString *city;

@property (nonatomic, strong) NSMutableAttributedString *end_time;

//@property (nonatomic, assign) BOOL canUse;


-(instancetype)initWithData:(NSDictionary *)dataSource;

@end
