//
//  CKWalletViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKWalletViewController.h"

@interface CKWalletViewController ()

@end

@implementation CKWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"我的钱包";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 300*PROPORTION750)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.clipsToBounds = YES;
    myView.layer.cornerRadius = 15.0*PROPORTION750;
    [self.view addSubview:myView];
    
    NSArray *icons = @[@"money_wallet",@"redPack_wallet",@"discount_wallet"];
    NSArray *titles = @[@"余额",@"红包",@"优惠券"];
    
    for (int i = 0; i < 3; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100*PROPORTION750*i, myView.width, 100*PROPORTION750)];
        [myView addSubview:view];
        
        if(i != 2)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 98*PROPORTION750, view.width, 2*PROPORTION750)];
            line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            [view addSubview:line];
        }
        
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        headImg.clipsToBounds = YES;
        headImg.layer.cornerRadius = 15*PROPORTION750;
        headImg.image = [UIImage imageNamed:icons[i]];
        [view addSubview:headImg];
        
        UILabel *headLB = [[UILabel alloc] initWithFrame:CGRectMake(headImg.right+30*PROPORTION750, 35*PROPORTION750, 140*PROPORTION750, 30*PROPORTION750)];
        headLB.text = titles[i];
        headLB.font = SYSF750(30);
        headLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:headLB];
        
        UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(view.width-218*PROPORTION750, 35*PROPORTION750, 140*PROPORTION750, 30*PROPORTION750)];
        detailLB.text = @"0.00";
        detailLB.font = SYSF750(22);
        detailLB.textAlignment = NSTextAlignmentRight;
        [view addSubview:detailLB];
        
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(view.width-48*PROPORTION750, 35*PROPORTION750, 18*PROPORTION750, 30*PROPORTION750)];
        rightImage.image = [UIImage imageNamed:@"right_wallet"];
        [view addSubview:rightImage];
        
    }
    
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
