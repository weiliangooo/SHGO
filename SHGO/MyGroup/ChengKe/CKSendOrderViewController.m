//
//  CKSendOrderViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSendOrderViewController.h"
#import "UIImage+ScalImage.h"
#import "CancleOrderAlertView.h"
#import "ResonForCancleViewController.h"
#import "CKSureOrderModel.h"
#import "CKMainViewController.h"

@interface CKSendOrderViewController ()<AlertClassDelegate>

@end

@implementation CKSendOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = @"正在派单中";
    
    UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-240*PROPORTION750-64, 690*PROPORTION750, 220*PROPORTION750)];
    msgView.backgroundColor = [UIColor whiteColor];
    msgView.clipsToBounds = YES;
    msgView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:msgView];
    
    UILabel * _startEndCityLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 298*PROPORTION750, 30*PROPORTION750)];
    _startEndCityLB.text = _startEndCity;
    _startEndCityLB.textColor = [UIColor colorWithHexString:@"#999999"];
    _startEndCityLB.font = SYSF750(30);
    [msgView addSubview:_startEndCityLB];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(318*PROPORTION750, 30*PROPORTION750, 2*PROPORTION750, 30*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [self.view addSubview:line1];
    
    UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(line1.right+15*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
    timeImage.image = [UIImage imageNamed:@"time"];
    [msgView addSubview:timeImage];
    
    UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right, 30*PROPORTION750, 305*PROPORTION750, 30*PROPORTION750)];
    timeLB.text = [NSString stringWithFormat:@"%@ 出发",_startTime];
    timeLB.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLB.font = SYSF750(25);
    [msgView addSubview:timeLB];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [msgView addSubview:line2];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:_startTime];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *start2 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(timeInterval - 3600)]];
    
    UILabel *msgLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line2.bottom+30*PROPORTION750, 630*PROPORTION750, 70*PROPORTION750)];
    msgLB.font = SYSF750(25);
    msgLB.numberOfLines = 2;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"系统将于%@为您派单，并安排司机来接您，请留意手机提醒并保持手机畅通。", start2]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"999999"]
                          range:NSMakeRange(0, 4)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"#1ead1a"]
                          range:NSMakeRange(4, 16)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"999999"]
                          range:NSMakeRange(20, AttributedStr.length-20)];
    msgLB.attributedText = AttributedStr;
    [msgView addSubview:msgLB];
    
}

-(void)leftBtn:(UIButton *)button{
    for (YHBaseViewController *viewController in self.navigationController.viewControllers){
        if ([viewController isKindOfClass:[CKMainViewController class]]) {
            CKMainViewController *mainVC = (CKMainViewController *)viewController;
            [self.navigationController popToViewController:mainVC animated:YES];
        }
    }
}

-(void)canCleBtnClickEvent{
    CancleOrderAlertView *alerView = [[CancleOrderAlertView alloc] initWithTipTitle:@"是否需要取消订单" TipImage:nil];
    alerView.delegate =self;
}

-(void)AlertClassView:(id)alertView clickIndex:(NSInteger)index{
    [alertView removeFromSuperview];
    if (index == 100){
        ResonForCancleViewController *viewController = [[ResonForCancleViewController alloc] init];
        viewController.orderNum = _orderNum;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    NSLog(@"%d",(int)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
