//
//  WalletDetailViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

typedef enum : NSUInteger {
    WalletTypeBalance,
    WalletTypeRed,
    WalletTypeDiscount,
} WalletType;

@class WalletMoneyModel;
@interface WalletDetailViewController : YHBaseViewController

-(instancetype)initWithType:(WalletType)type dataSource:(id)dataSource;

@end
