//
//  SetPassWordViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/15.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "UIImage+ScalImage.h"

@interface SetPassWordViewController ()
{
    UITextField *tf1;
    UITextField *tf2;
    UIButton *codeBtn;
    ///定时器
    NSTimer * timer;
    ///默认60 倒计时
    int countDownTime;
}
@end

@implementation SetPassWordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
}


-(void)setIsNormal:(BOOL)isNormal{
    _isNormal = isNormal;
    if (_isNormal) {
        UIView *back1 = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
        back1.backgroundColor = [UIColor whiteColor];
        back1.clipsToBounds = true;
        back1.layer.cornerRadius = 15*PROPORTION750;
        [self.view addSubview:back1];
        
        tf1 = [[UITextField alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 610*PROPORTION750, 50*PROPORTION750)];
        tf1.placeholder = @"旧密码";
        tf1.font = SYSF750(30);
        tf1.secureTextEntry = true;
        [back1 addSubview:tf1];
        
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(640*PROPORTION750, 25*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        [btn1 setImage:[[UIImage imageNamed:@"pass_close"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
        [btn1 setImage:[[UIImage imageNamed:@"pass_open"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 100;
        btn1.selected = false;
        [back1 addSubview:btn1];
        
        
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
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = SYSF750(40);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 300;
        [self.view addSubview:button];
    }else{
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, 30*PROPORTION750, 650*PROPORTION750, 30*PROPORTION750)];
        tipLabel.text = [NSString stringWithFormat:@"验证码已发送到手机 %@",[[MyHelperNO getMyMobilePhone] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]];
        tipLabel.textColor = [UIColor colorWithHexString:@"999999"];
        tipLabel.font = SYSF750(30);
        tipLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:tipLabel];
        
        UIView *back1 = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, tipLabel.bottom+30*PROPORTION750, 470*PROPORTION750, 90*PROPORTION750)];
        back1.backgroundColor = [UIColor whiteColor];
        back1.clipsToBounds = true;
        back1.layer.cornerRadius = 15*PROPORTION750;
        [self.view addSubview:back1];
        
        tf1 = [[UITextField alloc] initWithFrame:CGRectMake(30*PROPORTION750, 20*PROPORTION750, 410*PROPORTION750, 50*PROPORTION750)];
        tf1.placeholder = @"验证码";
        tf1.font = SYSF750(30);
        [back1 addSubview:tf1];
        
        codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(back1.right+30*PROPORTION750, back1.top, 210*PROPORTION750, 90*PROPORTION750)];
        codeBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        codeBtn.titleLabel.font = SYSF750(30);
        codeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        codeBtn.clipsToBounds = YES;
        codeBtn.layer.cornerRadius = 15.0f*PROPORTION750;
        codeBtn.tag = 100;
        [codeBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
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
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = SYSF750(40);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 400;
        [self.view addSubview:button];
        
        [self getVerificationCode];
    }
}


-(void)buttonClickEvents:(UIButton *)button{
    if (button.tag == 100) {
        button.selected = !button.selected;
        if (button.selected) {
            tf1.secureTextEntry = false;
        }else{
            tf1.secureTextEntry = true;
        }
    }else if (button.tag == 200){
        button.selected = !button.selected;
        if (button.selected) {
            tf2.secureTextEntry = false;
        }else{
            tf2.secureTextEntry = true;
        }
    }else{
        NSMutableDictionary *reqDic;
        if (button.tag == 300){
            if (tf1.text.length == 0) {
                [self toast:@"请填写旧密码"];
                return;
            }
            
            if (tf2.text.length == 0) {
                [self toast:@"请填写新密码"];
                return;
            }
            
            if (tf1.text.length < 6) {
                [self toast:@"请正确填写旧密码"];
                return;
            }
            
            if (tf2.text.length < 6) {
                [self toast:@"密码不得少于6位"];
                return;
            }
            
            if ([tf2.text isEqualToString:tf1.text]) {
                [self toast:@"新密码不能与旧密码相同"];
                return;
            }
            
            reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      tf1.text, @"old_pass",
                      tf2.text, @"pass",
                      [MyHelperNO getUid], @"uid",
                      [MyHelperNO getMyToken], @"token", nil];
            
        }else{
            if (tf1.text.length == 0) {
                [self toast:@"请填写验证码"];
                return;
            }
            
            if (tf2.text.length == 0) {
                [self toast:@"请填写新密码"];
                return;
            }
            
            if (tf2.text.length < 6) {
                [self toast:@"密码不得少于6位"];
                return;
            }
            
            reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      tf1.text, @"code",
                      tf2.text, @"pass",
                      [MyHelperNO getUid], @"uid",
                      [MyHelperNO getMyToken], @"token", nil];
        }
//        reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[MyHelperNO getUid], @"uid",[MyHelperNO getMyToken], @"token", nil];
        [self post:@"user/update_pass" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSLog(@"%@", responseObject);
            NSString *msg = [responseObject stringForKey:@"msg"];
            if (code == 200){
                [self toast:@"修改成功"];
                [self performSelector:@selector(gotoRootViewController) withObject:nil afterDelay:1.5];
            }else if (code == 300){
                [self toast:@"身份认证已过期"];
                [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
            }else{
                [self toast:msg];
            }
        } failure:^(NSError *error) {
            
        }];

    }
}

- (void)getVerificationCode{
    
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[MyHelperNO getUid], @"uid",[MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/send_code" withParam:reqDic success:^(id responseObject) {
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


-(void)gotoRootViewController{
    [self.navigationController popViewControllerAnimated:true];
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
