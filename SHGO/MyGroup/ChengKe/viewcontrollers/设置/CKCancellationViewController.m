//
//  CKCancellationViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKCancellationViewController.h"

@interface CKCancellationViewController ()

@end

@implementation CKCancellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"注销账户";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 480*PROPORTION750)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.clipsToBounds = YES;
    myView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:myView];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(280*PROPORTION750, 30*PROPORTION750, 159*PROPORTION750, 150*PROPORTION750)];
    headImgView.clipsToBounds = YES;
    headImgView.layer.cornerRadius = 75*PROPORTION750;
    headImgView.image = [UIImage imageNamed:@"test001"];
    [myView addSubview:headImgView];
    
    UILabel *warn1LB = [[UILabel alloc] initWithFrame:CGRectMake(0, headImgView.bottom+30*PROPORTION750, 710*PROPORTION750, 30*PROPORTION750)];
    warn1LB.text = @"将153****1234所绑定的账号注销";
    warn1LB.font = SYSF750(30);
    warn1LB.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:warn1LB];
    
    UILabel *warn2LB = [[UILabel alloc] initWithFrame:CGRectMake(0, warn1LB.bottom+30*PROPORTION750, 710*PROPORTION750, 30*PROPORTION750)];
    warn2LB.text = @"请注意，注销账号以下信息将被清空且无法找回";
    warn2LB.textColor = [UIColor colorWithHexString:@"999999"];
    warn2LB.font = SYSF750(27);
    warn2LB.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:warn2LB];
    
    NSArray *tips = @[@"*行程信息",@"*免费乘车险信息",@"*个人隐私信息"];
    for (int i = 0; i < 3; i++)
    {
        NSString *tip = tips[i];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:tip];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#19af15"] range:NSMakeRange(0, 1)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(1, tip.length-1)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, warn2LB.bottom+25*PROPORTION750+50*PROPORTION750*i, 590*PROPORTION750, 25*PROPORTION750)];
        label.font = SYSF750(25);
        label.textAlignment = NSTextAlignmentLeft;
        label.attributedText = string;
        [myView addSubview:label];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, AL_DEVICE_HEIGHT-110*PROPORTION750-64, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [button setTitle:@"注销账号" forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15.0f*PROPORTION750;
    [button addTarget:self action:@selector(butonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)butonClickEvent:(UIButton *)button
{

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
