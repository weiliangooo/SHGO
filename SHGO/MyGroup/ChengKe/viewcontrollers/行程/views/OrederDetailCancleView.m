//
//  OrederDetailCancleView.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrederDetailCancleView.h"

@implementation OrederDetailCancleView

-(instancetype)init{
    if(self =[super init]){
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
    }
    return self;
}


@end
