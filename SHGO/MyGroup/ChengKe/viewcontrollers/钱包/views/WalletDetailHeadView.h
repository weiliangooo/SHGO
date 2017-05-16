//
//  WalletDetailHeadView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletDetailHeadView : UIView

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) UIButton *tipBtn;

@property (nonatomic, copy) void (^buttonBlock)();


@end
