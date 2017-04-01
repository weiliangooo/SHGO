//
//  CKOnTheWayViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/30.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKOnTheWayViewController.h"
#import "Star.h"

@interface CKOnTheWayViewController ()

@end

@implementation CKOnTheWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.topTitle = @"行程中";
    
    UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-260*PROPORTION750-64, 690*PROPORTION750, 240*PROPORTION750)];
    msgView.backgroundColor = [UIColor whiteColor];
//    msgView.clipsToBounds = YES;
//    msgView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:msgView];
    
    UILabel *driverLB = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, 20*PROPORTION750, 130*PROPORTION750, 40*PROPORTION750)];
    driverLB.text = @"王师傅";
    driverLB.font = SYSF750(30);
    driverLB.textAlignment = NSTextAlignmentLeft;
    [msgView addSubview:driverLB];
    
    UIImageView *phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(driverLB.right, 20*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
    phoneImgView.image = [UIImage imageNamed:@"phone"];
    [msgView addSubview:phoneImgView];
    
    Star *myStar = [[Star alloc] initWithFrame:CGRectMake(50*PROPORTION750, driverLB.bottom+25*PROPORTION750, 170*PROPORTION750, 30*PROPORTION750)];
    myStar.isSelect = NO;
    myStar.max_star = 5;
    myStar.show_star = 3.5;
    myStar.font_size = 30*PROPORTION750;
    [msgView addSubview:myStar];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(270*PROPORTION750, -45*PROPORTION750, 150*PROPORTION750, 150*PROPORTION750)];
    headImgView.clipsToBounds = YES;
    headImgView.layer.cornerRadius = 75*PROPORTION750;
    headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImgView.layer.borderWidth = 8*PROPORTION750;
    headImgView.image = [UIImage imageNamed:@"head"];
    headImgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    headImgView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    headImgView.layer.shadowOpacity = 1;//阴影透明度，默认0
    headImgView.layer.shadowRadius = 3;//阴影半径，默认3
    [msgView addSubview:headImgView];
    
    UILabel *carNumLB = [[UILabel alloc] initWithFrame:CGRectMake(270*PROPORTION750, 85*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
    carNumLB.backgroundColor = [UIColor whiteColor];
//    carNumLB.clipsToBounds = YES;
//    carNumLB.layer.cornerRadius = 5*PROPORTION750;
    carNumLB.text = @"皖ALLLLLL";
    carNumLB.font = SYSF750(20);
    carNumLB.textAlignment = NSTextAlignmentCenter;
    carNumLB.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    carNumLB.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    carNumLB.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    carNumLB.layer.shadowRadius = 5;//阴影半径，默认3
    [msgView addSubview:carNumLB];
    
    UILabel *carBrandLB = [[UILabel alloc] initWithFrame:CGRectMake(470*PROPORTION750, 20*PROPORTION750, 170*PROPORTION750, 40*PROPORTION750)];
    carBrandLB.text = @"海马v70";
    carBrandLB.font = SYSF750(30);
    carBrandLB.textAlignment = NSTextAlignmentCenter;
    [msgView addSubview:carBrandLB];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 150*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [msgView addSubview:line];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 152*PROPORTION750, 690*PROPORTION750, 88*PROPORTION750)];
    [button setTitle:@"分享此次行程获得现金红包" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(25);
    [button setImage:[UIImage imageNamed:@"ckselected"] forState:UIControlStateNormal];
    [msgView addSubview:button];
    
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
