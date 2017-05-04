//
//  CKMsgDetailViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/25.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMsgDetailViewController.h"
#import "YHBaseViewController+ext.h"
#import "MsgListModel.h"

@interface CKMsgDetailViewController ()

@end

@implementation CKMsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = @"消息";
    self.type = 1;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 190*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.clipsToBounds = YES;
    backView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:backView];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 35*PROPORTION750, 300*PROPORTION750, 25*PROPORTION750)];
    tipLB.text = @"【小马出行】温馨提示";
    tipLB.font = SYSF750(25);
    tipLB.textColor = [UIColor colorWithHexString:@"#1aad19"];
    [backView addSubview:tipLB];
    
    CGSize size = [self currentText:_model.msgContent textFont:SYSF750(30) maxSize:CGSizeMake(650*PROPORTION750, 600*PROPORTION750)];
    
    UILabel * contentLB = [[UILabel alloc] initWithFrame:CGRectMake(tipLB.left, tipLB.bottom+30*PROPORTION750, size.width, size.height)];
    contentLB.text = _model.msgContent;
    contentLB.font = SYSF750(30);
    contentLB.textAlignment = NSTextAlignmentLeft;
    contentLB.numberOfLines = 0;
    [backView addSubview:contentLB];
    
    backView.height = 120*PROPORTION750 + size.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}



@end
