//
//  OrderDetailHadCommedView.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderDetailHadCommedView.h"
#import "MyStar.h"
#import "UIImage+ScalImage.h"

@implementation OrderDetailHadCommedView

 -(instancetype)init{
     if(self =[super init]){
         UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-64-130*PROPORTION750, AL_DEVICE_WIDTH, 130*PROPORTION750)];
         btnView.backgroundColor = [UIColor whiteColor];
         [self addSubview:btnView];
         
         self.scollerView.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64-130*PROPORTION750);
         self.scollerView.contentSize = CGSizeMake(AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64-130*PROPORTION750+1);
         
         UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 690*PROPORTION750, 90*PROPORTION750)];
         payBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
         payBtn.clipsToBounds = YES;
         payBtn.layer.cornerRadius = 15*PROPORTION750;
         [payBtn setTitle:@"分享行程" forState:UIControlStateNormal];
         payBtn.titleLabel.font = SYSF750(35);
         payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
         [payBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
         [btnView addSubview:payBtn];
         [self driverMsgWithView:self.orderMsgView];
     }
     
     return self;
 }

-(void)driverMsgWithView:(UIView *)lastView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, lastView.bottom+20*PROPORTION750, 710*PROPORTION750, 1000)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.clipsToBounds = true;
    backView.layer.cornerRadius = 15*PROPORTION750;
    [self.scollerView addSubview:backView];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 650*PROPORTION750, 90*PROPORTION750)];
    tipLB.text = @"司机";
    tipLB.font = SYSF750(30);
    tipLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:tipLB];
    
    UIButton *cButton = [[UIButton alloc] initWithFrame:CGRectMake(710*PROPORTION750-230*PROPORTION750, 0, 200*PROPORTION750, 90*PROPORTION750)];
    [cButton setTitle:@"我要投诉" forState:UIControlStateNormal];
    [cButton setTitleColor:[UIColor colorWithHexString:@"1aad19"] forState:UIControlStateNormal];
    cButton.titleLabel.font = SYSF750(30);
    [cButton setImage:[[UIImage imageNamed:@"comIcon"] scaleImageByWidth:30*PROPORTION750] forState:UIControlStateNormal];
    [cButton addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cButton];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 90*PROPORTION750, backView.width, 2*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backView addSubview:line1];
    
    self.driverNameLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line1.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    self.driverNameLB.text = @"王师傅";
    self.driverNameLB.font = SYSF750(30);
    self.driverNameLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:self.driverNameLB];
    
    self.starView = [[MyStar alloc] initWithFrame:CGRectMake(355*PROPORTION750, line1.bottom, 325*PROPORTION750, 90*PROPORTION750) space:20*PROPORTION750];
    [self.starView setScore:4.2];
    [backView addSubview:self.starView];
    
    UILabel *carTypeTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, self.driverNameLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    carTypeTipLB.text = @"车辆";
    carTypeTipLB.font = SYSF750(30);
    carTypeTipLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:carTypeTipLB];
    
    self.carNameLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, self.driverNameLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    self.carNameLB .text = @"海马V70";
    self.carNameLB .textColor = [UIColor colorWithHexString:@"999999"];
    self.carNameLB .font = SYSF750(30);
    self.carNameLB .textAlignment = NSTextAlignmentRight;
    [backView addSubview:self.carNameLB ];
    
    UILabel *carNumTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, carTypeTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    carNumTipLB.text = @"车牌";
    carNumTipLB.font = SYSF750(30);
    carNumTipLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:carNumTipLB];
    
    self.carNumLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, carTypeTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    self.carNumLB.text = @"皖A12345";
    self.carNumLB.textColor = [UIColor colorWithHexString:@"999999"];
    self.carNumLB.font = SYSF750(30);
    self.carNumLB.textAlignment = NSTextAlignmentRight;
    [backView addSubview:self.carNumLB];
    
//    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, carNumTipLB.bottom, backView.width, 2*PROPORTION750)];
//    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    [backView addSubview:line2];
//    
//    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, line2.bottom, 710*PROPORTION750, 90*PROPORTION750)];
//    detailBtn.tag = 102;
//    [detailBtn setTitle:@"联系司机" forState:UIControlStateNormal];
//    [detailBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
//    detailBtn.titleLabel.font = SYSF750(25);
//    [detailBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:detailBtn];
    
    backView.height = self.carNumLB.bottom;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"如有其他问题请联系客服"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 7)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1aad19"] range:NSMakeRange(7, 4)];
    
    UIButton *kfBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, backView.bottom+20*PROPORTION750, 710*PROPORTION750, 25*PROPORTION750)];
    kfBtn.tag = 102;
    [kfBtn setAttributedTitle:string forState:UIControlStateNormal];
    kfBtn.titleLabel.font = SYSF750(25);
    [kfBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.scollerView addSubview:kfBtn];
    
    if (self.scollerView.height < kfBtn.bottom) {
        self.scollerView.contentSize = CGSizeMake(AL_DEVICE_WIDTH, kfBtn.bottom+20*PROPORTION750);
    }
}


@end
