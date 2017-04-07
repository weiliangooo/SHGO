//
//  CKLoginViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKLoginViewController.h"
#import "CKLoginTextField.h"
#import "ChengKeMainViewController.h"
#import "CKRealNameViewController.h"


@interface CKLoginViewController ()
{
    ///定时器
    NSTimer * timer;
    ///默认60 倒计时
    NSInteger countDownTime;
}
///登录输入框
@property (nonatomic, strong) CKLoginTextField *accountTF;
///验证码输入框
@property (nonatomic, strong) CKLoginTextField *codeTF;
///获取验证码按钮
@property (nonatomic, strong) UIButton *codeBT;

@end

@implementation CKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 100;
    /*
    [self.leftBtn setImage:nil forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = SYSF750(30);
     */
    
    ///每次只要调用登录界面则清除 本地数据
    [MyHelperNO removeAllData];
    
    self.topTitle = @"登录";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    
    _accountTF = [[CKLoginTextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750) leftImgName:@"shouj" placeholderTitle:@"请输入手机号码"];
    [self.view addSubview:_accountTF];
    
    
    _codeTF = [[CKLoginTextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, _accountTF.bottom+30*PROPORTION750, 470*PROPORTION750, 90*PROPORTION750) leftImgName:@"suo" placeholderTitle:@"请输入验证码"];
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
    
    
    UIButton *loginBT = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, _codeBT.bottom+50*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750)];
    loginBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [loginBT setTitle:@"登录" forState:UIControlStateNormal];
    loginBT.titleLabel.font = SYSF750(40);
    loginBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginBT.clipsToBounds = YES;
    loginBT.layer.cornerRadius = 15.0f*PROPORTION750;
    loginBT.tag = 101;
    [loginBT addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBT];
    
    
    UIButton *gouBT = [[UIButton alloc] initWithFrame:CGRectMake(205*PROPORTION750, loginBT.bottom+30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
    [gouBT setImage:[UIImage imageNamed:@"ckunselected"] forState:UIControlStateNormal];
    [gouBT setImage:[UIImage imageNamed:@"ckselected"] forState:UIControlStateSelected];
    [gouBT setSelected:YES];
    gouBT.tag = 102;
    [gouBT addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gouBT];
    
    
    UILabel *xyLB = [[UILabel alloc] initWithFrame:CGRectMake(245*PROPORTION750, gouBT.top, 400*PROPORTION750, 30*PROPORTION750)];
    xyLB.textAlignment = NSTextAlignmentLeft;
    xyLB.font = SYSF750(25);
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"同意《使用协议及隐私条款》"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithHexString:@"1aad19"]
                          range:NSMakeRange(3, 9)];
    xyLB.attributedText = AttributedStr;
    xyLB.userInteractionEnabled = YES;
    [xyLB addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xyLBClickEvent:)]];
    [self.view addSubview:xyLB];
    
}


-(void)buttonClickEvents:(UIButton *)button
{
    if (button.tag == 100)
    {
        if (![Regular isMobileNumber:_accountTF.myTextField.text])
        {
            [self toast:@"请输入正确的手机号码"];
        }
        else
        {
            [self getVerificationCode];
        }
    }
    else if (button.tag == 101)
    {
        if (_accountTF.myTextField.text.length == 0)
        {
            [self toast:@"请输入手机号码"];
            return;
        }
        
        if (_codeTF.myTextField.text.length == 0)
        {
            [self toast:@"请输入验证码"];
            return;
        }
        
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _accountTF.myTextField.text, @"phone",
                                       _codeTF.myTextField.text, @"code", nil];
        [self post:@"login/login" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSLog(@"%@", responseObject);
            NSString *msg = [responseObject stringForKey:@"msg"];
            if (code == 200)
            {
                NSDictionary *dic = [responseObject objectForKey:@"data"];
                [USERDEFAULTS setObject:[dic stringForKey:@"token"] forKey:@"token"];
                [USERDEFAULTS setObject:[dic stringForKey:@"is_realname"] forKey:@"realName"];
                [USERDEFAULTS setObject:[dic stringForKey:@"uid"] forKey:@"uid"];
                
                if ([[responseObject objectForKey:@"data"] intForKey:@"is_realname"] == 2)
                {
                    CKRealNameViewController *viewController = [[CKRealNameViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                else
                {
                    ChengKeMainViewController *viewController = [[ChengKeMainViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
            }
            else if (code == 400)
            {
                [self toast:msg];
            }
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    else if (button.tag == 102)
    {
        [button setSelected:!button.selected];
    }
}

-(void)xyLBClickEvent:(UITapGestureRecognizer *)tap
{
    NSLog(@"xieyi");
}

- (void)getVerificationCode
{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_accountTF.myTextField.text, @"phone", nil];
    [self post:@"login/index" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        if (code == 200)
        {
            countDownTime = 60;
            timer = [[NSTimer alloc]init];
            timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            [timer setFireDate:[NSDate distantPast]];
            //请求服务器发送短信验证码
            //......

        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)countDown
{
    countDownTime--;
    if (countDownTime < 0||countDownTime ==60)
    {
        _codeBT.userInteractionEnabled = YES;
        [_codeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        _codeBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    }
    else
    {
        _codeBT.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [_codeBT setTitle:[NSString stringWithFormat:@"(%lds)重新获取",countDownTime] forState:UIControlStateNormal];
        _codeBT.userInteractionEnabled = NO;
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
