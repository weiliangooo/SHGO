//
//  ResonForCancleViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ResonForCancleViewController.h"

@interface ResonForCancleViewController ()

@end

@implementation ResonForCancleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"取消原因";
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 820*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.clipsToBounds = YES;
    backView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:backView];
    
    UILabel *topTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*PROPORTION750, backView.width, 30*PROPORTION750)];
    topTitleLB.text = @"行程已取消，请告诉我们原因";
    topTitleLB.font = SYSF750(30);
    topTitleLB.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:topTitleLB];
    
//    UILabel *tipLB = [UILabel alloc] init
    
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
