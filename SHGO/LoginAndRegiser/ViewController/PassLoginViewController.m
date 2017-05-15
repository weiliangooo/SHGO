//
//  PassLoginViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/15.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "PassLoginViewController.h"
#import "UIImage+ScalImage.h"
#import "ForgetPassViewController.h"

@interface PassLoginViewController ()
{
    UITextField *tf1;
    UITextField *tf2;
}
@end

@implementation PassLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"密码登录";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *back1 = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    back1.backgroundColor = [UIColor whiteColor];
    back1.clipsToBounds = true;
    back1.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:back1];
    
    tf1 = [[UITextField alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 610*PROPORTION750, 50*PROPORTION750)];
    tf1.placeholder = @"手机号／用户名";
    tf1.font = SYSF750(30);
    tf1.secureTextEntry = true;
    [back1 addSubview:tf1];
    
    UIView *back2 = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, back1.bottom+30*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    back2.backgroundColor = [UIColor whiteColor];
    back2.clipsToBounds = true;
    back2.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:back2];
    
    tf2 = [[UITextField alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 610*PROPORTION750, 50*PROPORTION750)];
    tf2.placeholder = @"新密码";
    tf2.font = SYSF750(30);
    tf2.secureTextEntry = true;
    [back2 addSubview:tf2];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(640*PROPORTION750, 25*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
    [btn2 setImage:[[UIImage imageNamed:@"pass_close"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
    [btn2 setImage:[[UIImage imageNamed:@"pass_open"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 200;
    btn2.selected = false;
    [back2 addSubview:btn2];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, back2.bottom+50*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 300;
    [self.view addSubview:button];
    
    UILabel *forgetLB = [[UILabel alloc] initWithFrame:CGRectMake(20*PROPORTION750, button.bottom+30*PROPORTION750, 710*PROPORTION750, 30*PROPORTION750)];
    forgetLB.text = @"忘记密码？";
    forgetLB.textColor = [UIColor colorWithHexString:@"#999999"];
    forgetLB.font = SYSF750(30);
    forgetLB.userInteractionEnabled = true;
    forgetLB.textAlignment = NSTextAlignmentRight;
    [forgetLB addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetViewTap:)]];
    [self.view addSubview:forgetLB];
}

-(void)buttonClickEvents:(UIButton *)button{
    if (button.tag == 200){
        button.selected = !button.selected;
        if (button.selected) {
            tf2.secureTextEntry = false;
        }else{
            tf2.secureTextEntry = true;
        }
    }else if (button.tag == 300){
        
    }
}

-(void)forgetViewTap:(UITapGestureRecognizer *)tap{
    ForgetPassViewController *viewController = [[ForgetPassViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:true];
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
