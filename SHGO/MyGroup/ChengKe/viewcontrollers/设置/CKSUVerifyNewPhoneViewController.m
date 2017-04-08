//
//  CKSUVerifyNewPhoneViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSUVerifyNewPhoneViewController.h"
#import "CKLoginTextField.h"

@interface CKSUVerifyNewPhoneViewController ()
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

@property (nonatomic, strong) UIView *tipView;

@end

@implementation CKSUVerifyNewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 5;
    self.topTitle = @"验证新手机号";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    _accountTF = [[CKLoginTextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750) leftImgName:@"shouj" placeholderTitle:@"请输入更换手机号码"];
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
    
    [self.view addSubview:[self tipView:_codeBT]];
    
    
    UIButton *loginBT = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, _tipView.bottom+50*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750)];
    loginBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [loginBT setTitle:@"提交" forState:UIControlStateNormal];
    loginBT.titleLabel.font = SYSF750(40);
    loginBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginBT.clipsToBounds = YES;
    loginBT.layer.cornerRadius = 15.0f*PROPORTION750;
    loginBT.tag = 101;
    [loginBT addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBT];
}

-(UIView *)tipView:(UIView *)lastView
{
    _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, lastView.bottom+50*PROPORTION750, AL_DEVICE_WIDTH, 180*PROPORTION750)];
    _tipView.backgroundColor = [UIColor clearColor];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 11.5*PROPORTION750, 315*PROPORTION750, 2*PROPORTION750)];
    line1.backgroundColor = [UIColor whiteColor];
    [_tipView addSubview:line1];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(315*PROPORTION750, 0, 120*PROPORTION750, 25*PROPORTION750)];
    titleLB.backgroundColor = [UIColor clearColor];
    titleLB.text = @"注意事项";
    titleLB.textColor = [UIColor colorWithHexString:@"999999"];
    titleLB.font = SYSF750(25);
    titleLB.textAlignment = NSTextAlignmentCenter;
    [_tipView addSubview:titleLB];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(titleLB.right, 11.5*PROPORTION750, 315*PROPORTION750, 2*PROPORTION750)];
    line2.backgroundColor = [UIColor whiteColor];
    [_tipView addSubview:line2];
    
    NSArray *tips = @[@"*1个月只能更换一次",@"*更换手机号不影响账户内容和数据",@"*您将使用新手机号登录"];
    for (int i = 0; i < 3; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, 30*PROPORTION750+50*PROPORTION750*i, 650*PROPORTION750, 25*PROPORTION750)];
        label.text = tips[i];
        label.textColor = [UIColor colorWithHexString:@"999999"];
        label.font = SYSF750(25);
        label.textAlignment = NSTextAlignmentLeft;
        [_tipView addSubview:label];
    }
    return _tipView;
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
        
        
    }
    
}


- (void)getVerificationCode
{
    //    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_accountTF.myTextField.text, @"phone", nil];
    //    [self post:@"login/index" withParam:reqDic success:^(id responseObject) {
    //        int code = [responseObject intForKey:@"status"];
    //        NSLog(@"%@", responseObject);
    //        if (code == 200)
    //        {
    countDownTime = 60;
    timer = [[NSTimer alloc]init];
    timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate distantPast]];
    //请求服务器发送短信验证码
    //......
    
    //        }
    //    } failure:^(NSError *error) {
    //
    //    }];
    
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
