//
//  CKSendOrderViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSendOrderViewController.h"

@interface CKSendOrderViewController ()

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
    _startEndCityLB.text = @"合肥市——>桐城市";
    _startEndCityLB.textColor = [UIColor colorWithHexString:@"#999999"];
    _startEndCityLB.font = SYSF750(30);
    [msgView addSubview:_startEndCityLB];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(318*PROPORTION750, 30*PROPORTION750, 2*PROPORTION750, 30*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [self.view addSubview:line1];
    
    UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(line1.right+15*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
    timeImage.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [msgView addSubview:timeImage];
    
    UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right, 30*PROPORTION750, 305*PROPORTION750, 30*PROPORTION750)];
    timeLB.text = @"今天（03-21）10:00 出发";
    timeLB.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLB.font = SYSF750(25);
    [msgView addSubview:timeLB];
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [msgView addSubview:line2];
    
    UILabel *msgLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line2.bottom+30*PROPORTION750, 630*PROPORTION750, 70*PROPORTION750)];
//    msgLB.text = @"系统将于今天（03-21）10:00为您派单，并安排司机来接您。请留意手机提醒并保持手机畅通。";
    msgLB.font = SYSF750(25);
    msgLB.numberOfLines = 2;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"系统将于今天（03-21）10:00为您派单，并安排司机来接您。请留意手机提醒并保持手机畅通。"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"999999"]
                          range:NSMakeRange(0, 4)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"#1ead1a"]
                          range:NSMakeRange(4, 14)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"999999"]
                          range:NSMakeRange(18, 29)];
    msgLB.attributedText = AttributedStr;
    [msgView addSubview:msgLB];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
