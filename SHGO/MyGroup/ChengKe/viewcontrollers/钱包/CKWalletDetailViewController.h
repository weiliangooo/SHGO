//
//  CKWalletDetailViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@class WalletMoneyModel;
@interface CKWalletDetailViewController : YHBaseViewController

-(instancetype)initWithData:(WalletMoneyModel *)dataSource;

@end


@interface CKWalletDetailHeader : UIView

@property (nonatomic, strong) NSString *price;

@property (nonatomic, copy) void (^buttonBlock)();

@end


@interface CKWalletListCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) UILabel *typeLB;

@property (nonatomic, strong) UILabel *moneyLB;

@end
