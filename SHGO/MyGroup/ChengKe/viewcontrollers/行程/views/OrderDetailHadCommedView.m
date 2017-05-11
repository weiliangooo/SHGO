//
//  OrderDetailHadCommedView.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderDetailHadCommedView.h"
#import "MyStar.h"

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
     //        [payBtn addTarget:self action:@selector(payBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
     [btnView addSubview:payBtn];
     }
     return self;
 }

-(void)driverMsgWithView:(UIView *)lastView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, lastView.bottom+20*PROPORTION750, 710*PROPORTION750, 1000)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.clipsToBounds = true;
    backView.layer.cornerRadius = 15*PROPORTION750;
    [self addSubview:backView];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 650*PROPORTION750, 90*PROPORTION750)];
    tipLB.text = @"车辆人员概况";
    tipLB.font = SYSF750(30);
    tipLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:tipLB];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 90*PROPORTION750, backView.width, 2*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backView addSubview:line1];
    
    UILabel *startTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line1.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    startTipLB.text = @"王师傅";
    startTipLB.font = SYSF750(30);
    startTipLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:startTipLB];
    
    MyStar *startLB = [[MyStar alloc] initWithFrame:CGRectMake(355*PROPORTION750, line1.bottom, 325*PROPORTION750, 90*PROPORTION750) space:20*PROPORTION750];
    [startLB setScore:4.2];
    [backView addSubview:startLB];
    
    UILabel *carTypeTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, startTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    carTypeTipLB.text = @"车辆品牌";
    carTypeTipLB.font = SYSF750(30);
    carTypeTipLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:carTypeTipLB];
    
    UILabel *carTypeLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, startTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    carTypeLB.text = @"海马V70";
    carTypeLB.textColor = [UIColor colorWithHexString:@"999999"];
    carTypeLB.font = SYSF750(30);
    carTypeLB.textAlignment = NSTextAlignmentRight;
    [backView addSubview:carTypeLB];
    
    UILabel *carNumTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, carTypeTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    carNumTipLB.text = @"车辆牌照";
    carNumTipLB.font = SYSF750(30);
    carNumTipLB.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:carNumTipLB];
    
    UILabel *carNumLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, carTypeTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
    carNumLB.text = @"皖A12345";
    carNumLB.textColor = [UIColor colorWithHexString:@"999999"];
    carNumLB.font = SYSF750(30);
    carNumLB.textAlignment = NSTextAlignmentRight;
    [backView addSubview:carNumLB];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, carNumTipLB.bottom, backView.width, 2*PROPORTION750)];
    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backView addSubview:line2];
    
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, line2.bottom, 710*PROPORTION750, 90*PROPORTION750)];
    detailBtn.tag = 102;
    [detailBtn setTitle:@"联系司机" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    detailBtn.titleLabel.font = SYSF750(25);
    //        [detailBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:detailBtn];
    
    backView.height = line2.bottom+90*PROPORTION750;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"如有其他问题请联系客服"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 7)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1aad19"] range:NSMakeRange(7, 4)];
    
    UIButton *kfBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, backView.bottom+20*PROPORTION750, 710*PROPORTION750, 25*PROPORTION750)];
    kfBtn.tag = 102;
    [kfBtn setAttributedTitle:string forState:UIControlStateNormal];
    kfBtn.titleLabel.font = SYSF750(25);
    //        [detailBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:kfBtn];
}


@end
