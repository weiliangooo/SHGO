//
//  CKRedPackDRegularViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKRedPackDRegularViewController.h"

@interface CKRedPackDRegularViewController ()

@end

@implementation CKRedPackDRegularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.type = 1;
    self.topTitle = @"使用规则";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 320*PROPORTION750)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.clipsToBounds = YES;
    myView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:myView];
    
    UILabel *q1LB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, myView.width-80*PROPORTION750, 40*PROPORTION750)];
    q1LB.attributedText = [self stringForQuestion:YES inputStr:@"Q 如何领取红包？"];
    q1LB.textAlignment = NSTextAlignmentLeft;
    [myView addSubview:q1LB];
    
    UILabel *a1LB = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, q1LB.bottom+30*PROPORTION750, myView.width-100*PROPORTION750, 30*PROPORTION750)];
    a1LB.attributedText = [self stringForQuestion:NO inputStr:@"A 通过每日签到获取红包，连续签到奖励更多。"];
    a1LB.textAlignment = NSTextAlignmentLeft;
    a1LB.font = SYSF750(25);
    [myView addSubview:a1LB];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 168*PROPORTION750, myView.width, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [myView addSubview:line];
    
    UILabel *q2LB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, line.bottom+30*PROPORTION750, myView.width-80*PROPORTION750, 40*PROPORTION750)];
    q2LB.attributedText = [self stringForQuestion:YES inputStr:@"Q 红包如何使用？"];
    q2LB.textAlignment = NSTextAlignmentLeft;
    [myView addSubview:q2LB];
    
    UILabel *a2LB = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, q2LB.bottom+30*PROPORTION750, myView.width-100*PROPORTION750, 30*PROPORTION750)];
    a2LB.attributedText = [self stringForQuestion:NO inputStr:@"A 在支付车费时，将优先使用红包进行支付。"];
    a2LB.textAlignment = NSTextAlignmentLeft;
    a2LB.font = SYSF750(25);
    [myView addSubview:a2LB];
}

-(NSMutableAttributedString *)stringForQuestion:(BOOL)isQuestion inputStr:(NSString *)inputStr
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:inputStr];
    if (isQuestion)
    {
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#19af15"] range:NSMakeRange(0, 1)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(1, inputStr.length-1)];
        
        [string addAttribute:NSFontAttributeName value:SYSF750(40) range:NSMakeRange(0, 1)];
        [string addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(1, inputStr.length-1)];
    }
    else
    {
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#19af15"] range:NSMakeRange(0, 1)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(1, inputStr.length-1)];
        
    }
    return string;
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
