//
//  ForgetPassViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/15.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ForgetPassViewController.h"

@interface ForgetPassViewController ()
{
    UITextField *tf0;
    UITextField *tf1;
    UITextField *tf2;
    UITextField *tf3;
    
    UIButton *codeBtn;
    
    ///定时器
    NSTimer * timer;
    ///默认60 倒计时
    int countDownTime;
}
@end

@implementation ForgetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"忘记密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *back0 = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    back0.backgroundColor = [UIColor whiteColor];
    back0.clipsToBounds = true;
    back0.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:back0];
    
    tf0 = [[UITextField alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 610*PROPORTION750, 50*PROPORTION750)];
    tf0.placeholder = @"手机号";
    tf0.font = SYSF750(30);
//    tf0.secureTextEntry = true;
    tf0.keyboardType = UIKeyboardTypeNumberPad;
    [back0 addSubview:tf0];
    
    UIView *back1 = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, back0.bottom+30*PROPORTION750, 470*PROPORTION750, 90*PROPORTION750)];
    back1.backgroundColor = [UIColor whiteColor];
    back1.clipsToBounds = true;
    back1.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:back1];
    
    tf1 = [[UITextField alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 410*PROPORTION750, 50*PROPORTION750)];
    tf1.placeholder = @"验证码";
    tf1.font = SYSF750(30);
    tf1.keyboardType = UIKeyboardTypeNumberPad;
    [back1 addSubview:tf1];
    
    codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(back1.right+30*PROPORTION750, back1.top, 210*PROPORTION750, 90*PROPORTION750)];
    codeBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = SYSF750(30);
    codeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    codeBtn.clipsToBounds = YES;
    codeBtn.layer.cornerRadius = 15.0f*PROPORTION750;
    codeBtn.tag = 100;
    [codeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    
    
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
    
    UIView *back3 = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, back2.bottom+30*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    back3.backgroundColor = [UIColor whiteColor];
    back3.clipsToBounds = true;
    back3.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:back3];
    
    tf3 = [[UITextField alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 610*PROPORTION750, 50*PROPORTION750)];
    tf3.placeholder = @"确认密码";
    tf3.font = SYSF750(30);
    tf3.secureTextEntry = true;
    [back3 addSubview:tf3];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, back3.bottom+50*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 300;
    [self.view addSubview:button];
}


- (void)getVerificationCode{
    if (![Regular isMobileNumber:tf0.text]){
        [self toast:@"请输入正确的手机号码"];
        return;
    }
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:tf0.text, @"phone", nil];
    [self post:@"login/forget_pass" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        if (code == 200)
        {
            countDownTime = 60;
            timer = [[NSTimer alloc]init];
            timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            [timer setFireDate:[NSDate distantPast]];
        }
    } failure:^(NSError *error) {

    }];
    
}

-(void)countDown{
    countDownTime--;
    if (countDownTime < 0||countDownTime ==60){
        codeBtn.userInteractionEnabled = YES;
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        codeBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    }else{
        codeBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [codeBtn setTitle:[NSString stringWithFormat:@"已发送(%ds)",countDownTime] forState:UIControlStateNormal];
        codeBtn.userInteractionEnabled = NO;
    }
}

-(void)buttonClickEvent:(UIButton *)button{

    if (tf0.text.length == 0){
        [self toast:@"请输入手机号码"];
        return;
    }
    
    if (![Regular isMobileNumber:tf0.text]){
        [self toast:@"请输入正确的手机号码"];
        return;
    }
    
    if (tf1.text.length == 0){
        [self toast:@"请输入验证码"];
        return;
    }
    
    if (tf2.text.length == 0){
        [self toast:@"请输入新密码"];
        return;
    }
    
    if (tf3.text.length == 0){
        [self toast:@"请输入确认密码"];
        return;
    }
    
    if (![tf3.text isEqualToString:tf2.text]){
        [self toast:@"两次输入的密码不一样"];
        return;
    }
    
    
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   tf1.text, @"code",
                                   tf2.text, @"pass", nil];
    [self post:@"login/update_pass" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSString *msg = [responseObject stringForKey:@"msg"];
        NSLog(@"%@", responseObject);
        if (code == 200)
        {
            [self toast:@"修改成功！"];
            [self performSelector:@selector(gotoRootViewController) withObject:nil afterDelay:1.5];
        }
        else if (code == 400)
        {
            [self toast:msg];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)gotoRootViewController{
    [self.navigationController popViewControllerAnimated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
