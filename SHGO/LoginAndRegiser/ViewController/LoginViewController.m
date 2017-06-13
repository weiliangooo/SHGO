//
//  CKLoginViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//
#import "LoginViewController.h"
#import "LoginTextField.h"
#import "CKMainViewController.h"
#import "CKRealNameViewController.h"
#import "BaseNavViewController.h"
#import "MyWebViewController.h"
#import "PassLoginViewController.h"

@interface LoginViewController ()
{
    ///定时器
    NSTimer * timer;
    ///默认60 倒计时
    int countDownTime;
}
///登录输入框
@property (nonatomic, strong) LoginTextField *accountTF;
///验证码输入框
@property (nonatomic, strong) LoginTextField *codeTF;
///获取验证码按钮
@property (nonatomic, strong) UIButton *codeBT;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 4;
    self.topTitle = @"登录";
    [self.rightBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    ///每次只要调用登录界面则清除 本地数据
    [MyHelperNO removeAllData];
    
    _accountTF = [[LoginTextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750) leftImgName:@"shouj" placeholderTitle:@"请输入手机号码"];
    _accountTF.myTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_accountTF];
    
    _codeTF = [[LoginTextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, _accountTF.bottom+30*PROPORTION750, 470*PROPORTION750, 90*PROPORTION750) leftImgName:@"suo" placeholderTitle:@"请输入验证码"];
    _accountTF.myTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_codeTF];
    
    _codeBT = [[UIButton alloc] initWithFrame:CGRectMake(_codeTF.right+30*PROPORTION750, _codeTF.top, 210*PROPORTION750, 90*PROPORTION750)];
    _codeBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [_codeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeBT.titleLabel.font = SYSF750(30);
    _codeBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    _codeBT.clipsToBounds = YES;
    _codeBT.layer.cornerRadius = 15.0f*PROPORTION750;
    _codeBT.tag = 100;
    [_codeBT addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeBT];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"温馨提示：未注册小马出行账号的手机号，登录时将自动注册，且代表您已同意《网约车用户服务协议及安全保障细则》"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"1aad19"]
                          range:NSMakeRange(AttributedStr.length-17, 16)];
    
    UILabel *xyLB = [[UILabel alloc] initWithFrame:CGRectMake(20*PROPORTION750, _codeBT.bottom+50*PROPORTION750, 710*PROPORTION750, 100*PROPORTION750)];
    xyLB.textAlignment = NSTextAlignmentLeft;
    xyLB.font = SYSF750(25);
    xyLB.attributedText = AttributedStr;
    xyLB.userInteractionEnabled = YES;
    [xyLB addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xyLBClickEvent:)]];
    xyLB.numberOfLines = 0;
    [xyLB sizeToFit];
    [self.view addSubview:xyLB];
    
    
    UIButton *loginBT = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, xyLB.bottom+50*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750)];
    loginBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [loginBT setTitle:@"登录" forState:UIControlStateNormal];
    loginBT.titleLabel.font = SYSF750(40);
    loginBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginBT.clipsToBounds = YES;
    loginBT.layer.cornerRadius = 15.0f*PROPORTION750;
    loginBT.tag = 101;
    [loginBT addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBT];
    
}


-(void)buttonClickEvents:(UIButton *)button{
    if (button.tag == 100){
        if (![Regular isMobileNumber:_accountTF.myTextField.text]){
            [self toast:@"请输入正确的手机号码"];
            return;
        }else{
            [self getVerificationCode];
        }
    }else if (button.tag == 101){
        if (_accountTF.myTextField.text.length == 0){
            [self toast:@"请输入手机号码"];
            return;
        }
        
        if (![Regular isMobileNumber:_accountTF.myTextField.text]){
            [self toast:@"请输入正确的手机号码"];
            return;
        }
        
        if (_codeTF.myTextField.text.length == 0){
            [self toast:@"请输入验证码"];
            return;
        }
        
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _accountTF.myTextField.text, @"phone",
                                       _codeTF.myTextField.text, @"code", nil];
        [self post:@"login/login" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSString *msg = [responseObject stringForKey:@"msg"];
            NSLog(@"%@", responseObject);
            if (code == 200){
                NSDictionary *dic = [responseObject objectForKey:@"data"];
                [USERDEFAULTS setObject:[dic stringForKey:@"token"] forKey:@"token"];
                [USERDEFAULTS setObject:[dic stringForKey:@"is_realname"] forKey:@"realName"];
                [USERDEFAULTS setObject:[dic stringForKey:@"uid"] forKey:@"uid"];
                [USERDEFAULTS setObject:[dic stringForKey:@"avatar"] forKey:@"headImage"];
                [USERDEFAULTS setObject:_accountTF.myTextField.text forKey:@"mobilePhone"];
                
                if ([[responseObject objectForKey:@"data"] intForKey:@"is_realname"] == 2){
                    CKRealNameViewController *viewController = [[CKRealNameViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                else{
                    CKMainViewController *viewController = [[CKMainViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
            }
            else if (code == 400){
                [self toast:msg];
            }
        } failure:^(NSError *error) {
            
        }];
        
        
    }
}

-(void)xyLBClickEvent:(UITapGestureRecognizer *)tap{
    MyWebViewController *viewController = [[MyWebViewController alloc] initWithTopTitle:@"网约车用户服务协议" urlString:@"https://m.xiaomachuxing.com/index/use-agreement.html"];
    BaseNavViewController *navi = [[BaseNavViewController alloc] initWithRootViewController:viewController];
    [self presentViewController:navi animated:true completion:nil];
}

///获取验证码
- (void)getVerificationCode{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_accountTF.myTextField.text, @"phone", nil];
    [self post:@"login/index" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        if (code == 200){
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
        _codeBT.userInteractionEnabled = YES;
        [_codeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        _codeBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    }else{
        _codeBT.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [_codeBT setTitle:[NSString stringWithFormat:@"(%ds)重新获取",countDownTime] forState:UIControlStateNormal];
        _codeBT.userInteractionEnabled = NO;
    }
}

-(void)rightBtn:(UIButton *)button{
    PassLoginViewController *viewController = [[PassLoginViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
