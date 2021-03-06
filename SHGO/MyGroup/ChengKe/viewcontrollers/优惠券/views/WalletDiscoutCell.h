//
//  WalletDiscoutCell.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WalletQuanListModel;
@interface WalletDiscoutCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) UILabel *cityLB;

@property (nonatomic, strong) WalletQuanListModel *model;

@end
