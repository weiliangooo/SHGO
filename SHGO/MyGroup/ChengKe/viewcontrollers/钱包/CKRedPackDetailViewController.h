//
//  CKRedPaceDetailViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

typedef enum : NSUInteger {
    MoneyTypeWallet,
    MoneyTypeRed,
} MoneyType;

@class WalletMoneyModel;
@interface CKRedPackDetailViewController : YHBaseViewController

-(instancetype)initWithData:(WalletMoneyModel *)dataSource;

@end

@interface CKRedPackDetailHeader : UIView

@property (nonatomic, strong) NSString *price;

@property (nonatomic, copy) void (^buttonBlock)();

@end


@interface CKRedPackListCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) UILabel *typeLB;

@property (nonatomic, strong) UILabel *moneyLB;

@end
