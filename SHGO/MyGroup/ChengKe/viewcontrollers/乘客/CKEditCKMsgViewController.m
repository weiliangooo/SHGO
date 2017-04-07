//
//  CKEditCKMsgViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKEditCKMsgViewController.h"

@interface CKEditCKMsgViewController ()

@end

@implementation CKEditCKMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"修改";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *editView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 270*PROPORTION750)];
    editView.backgroundColor = [UIColor whiteColor];
    editView.clipsToBounds = YES;
    editView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:editView];
    
    NSArray *titles = @[@"姓名",@"身份证号码",@"手机号码"];
    NSArray *placeholders = @[@"请输入姓名", @"请输入身份证号", @"请输入手机号码"];
    for (int i = 0; i < 3; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 90*PROPORTION750*i, editView.width, 90*PROPORTION750)];
        [editView addSubview:view];
        
        if (i != 2)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, view.width, 2*PROPORTION750)];
            line.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
            [view addSubview:line];
        }
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 200*PROPORTION750, 30*PROPORTION750)];
        titleLB.text = titles[i];
        titleLB.font = SYSF750(30);
        titleLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:titleLB];
        
        UITextField *textTF = [[UITextField alloc] initWithFrame:CGRectMake(titleLB.right, 30*PROPORTION750, 450*PROPORTION750, 30*PROPORTION750)];
        textTF.tag = 100+i;
        textTF.placeholder = placeholders[i];
        textTF.font = SYSF750(25);
        [view addSubview:textTF];
    }
    
    UILabel *tip1 = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, editView.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-100*PROPORTION750, 25*PROPORTION750)];
    tip1.text = @"*这些信息用来登记和赠送保险";
    tip1.textColor = [UIColor colorWithHexString:@"999999"];
    tip1.font = SYSF750(25);
    tip1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tip1];
    
    UILabel *tip2 = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, tip1.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-100*PROPORTION750, 25*PROPORTION750)];
    tip2.text = @"*小马出行规定每个账号最多允许添加15个联系人";
    tip2.textColor = [UIColor colorWithHexString:@"999999"];
    tip2.font = SYSF750(25);
    tip2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tip2];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, tip2.bottom+50*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:button];
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
