//
//  WalletDetailHeadView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletDetailHeadView.h"

@implementation WalletDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15*PROPORTION750;
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 380*PROPORTION750, 25*PROPORTION750)];
        titleLB.text = @"余额（元）";
        titleLB.textColor = [UIColor colorWithHexString:@"999999"];
        titleLB.textAlignment = NSTextAlignmentLeft;
        titleLB.font = SYSF750(25);
        [self addSubview:titleLB];
        
        _tipBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-180*PROPORTION750, 27.5*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
        [_tipBtn setImage:[UIImage imageNamed:@"regular_wallet"] forState:UIControlStateNormal];
        [_tipBtn setTitle:@"常见问题" forState:UIControlStateNormal];
        [_tipBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        _tipBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _tipBtn.titleLabel.font = SYSF750(25);
        [_tipBtn addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_tipBtn];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 83*PROPORTION750, self.width, 2*PROPORTION750)];
        line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line1];
        
        _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, line1.bottom+30*PROPORTION750, 380*PROPORTION750, 50*PROPORTION750)];
        _priceLB.text = @"5.00元";
        _priceLB.textColor = [UIColor colorWithHexString:@"#1bac1a"];
        _priceLB.textAlignment = NSTextAlignmentLeft;
        _priceLB.font = SYSF750(50);
        [self addSubview:_priceLB];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 193*PROPORTION750, self.width, 2*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line2];
        
        UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, line2.bottom+30*PROPORTION750, 380*PROPORTION750, 25*PROPORTION750)];
        tipLB.text = @"支付车费时优先选择";
        tipLB.textColor = [UIColor colorWithHexString:@"999999"];
        tipLB.textAlignment = NSTextAlignmentLeft;
        tipLB.font = SYSF750(25);
        [self addSubview:tipLB];
        
    }
    return self;
}

-(void)buttonClickEvent:(UIButton *)button
{
    self.buttonBlock();
}


@end
