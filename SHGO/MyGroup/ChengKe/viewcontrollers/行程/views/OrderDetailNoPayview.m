//
//  OrderDetailNoPayview.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderDetailNoPayview.h"

@implementation OrderDetailNoPayview

-(instancetype)init{
    if(self =[super init]){
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-64-130*PROPORTION750, AL_DEVICE_WIDTH, 130*PROPORTION750)];
        btnView.backgroundColor = [UIColor whiteColor];
        [self addSubview:btnView];
        
        self.scollerView.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64-130*PROPORTION750);
        self.scollerView.contentSize = CGSizeMake(AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64-130*PROPORTION750+1);
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"如有其他问题请联系客服"];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 7)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1aad19"] range:NSMakeRange(7, 4)];
        
        UIButton *kfBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.orderMsgView.bottom+20*PROPORTION750, 710*PROPORTION750, 25*PROPORTION750)];
        kfBtn.tag = 102;
        [kfBtn setAttributedTitle:string forState:UIControlStateNormal];
        kfBtn.titleLabel.font = SYSF750(25);
        [kfBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self.scollerView addSubview:kfBtn];
        
        UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 330*PROPORTION750, 90*PROPORTION750)];
        payBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        payBtn.clipsToBounds = YES;
        payBtn.layer.cornerRadius = 15*PROPORTION750;
        [payBtn setTitle:@"我要付款" forState:UIControlStateNormal];
        payBtn.titleLabel.font = SYSF750(35);
        payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [payBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:payBtn];
        
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(payBtn.right+30*PROPORTION750, 20*PROPORTION750, 330*PROPORTION750, 90*PROPORTION750)];
        cancleBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        cancleBtn.clipsToBounds = YES;
        cancleBtn.layer.cornerRadius = 15*PROPORTION750;
        [cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = SYSF750(35);
        cancleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancleBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:cancleBtn];
    }
    return self;
}


@end
