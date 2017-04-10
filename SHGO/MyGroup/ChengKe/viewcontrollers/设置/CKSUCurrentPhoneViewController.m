//
//  CKSUCurrentPhoneViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSUCurrentPhoneViewController.h"
#import "CKSUVerifyCurrentPhoneViewController.h"

@interface CKSUCurrentPhoneViewController ()

@end

@implementation CKSUCurrentPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"手机号";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.clipsToBounds = YES;
    myView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:myView];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 220*PROPORTION750, 90*PROPORTION750)];
    titleLB.text = @"当前手机号";
    titleLB.font = SYSF750(25);
    titleLB.textAlignment = NSTextAlignmentLeft;
    [myView addSubview:titleLB];
    
    UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(380*PROPORTION750, 0, 300*PROPORTION750, 90*PROPORTION750)];
    detailLB.text = @"153****1234";
    detailLB.textColor = [UIColor colorWithHexString:@"999999"];
    detailLB.font = SYSF750(22);
    detailLB.textAlignment = NSTextAlignmentRight;
    [myView addSubview:detailLB];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, myView.bottom+50*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"更换手机号" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(changePhoneEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)changePhoneEvent:(UIButton *)button
{
    CKSUVerifyCurrentPhoneViewController *viewController = [[CKSUVerifyCurrentPhoneViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
