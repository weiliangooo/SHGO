//
//  CKAddCKMsgViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKAddCKMsgViewController.h"

@interface CKAddCKMsgViewController ()

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) UITextField *nameTF;

@property (nonatomic, strong) UITextField *IdTF;

@property (nonatomic, strong) UITextField *phoneTF;

@end

@implementation CKAddCKMsgViewController

-(UIScrollView *)myScrollView
{
    if (!_myScrollView)
    {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
        _myScrollView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    }
    return _myScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"添加乘客";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    [self.view addSubview:self.myScrollView];

    [self createTitleView];
}


-(void)createTitleView
{
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*PROPORTION750, AL_DEVICE_WIDTH, 30*PROPORTION750)];
    title1.text = @"遇到意外怎么办？有小马出行免费乘车意外险";
    title1.textColor = [UIColor colorWithHexString:@"1aad19"];
    title1.font = SYSF750(30);
    title1.textAlignment = NSTextAlignmentCenter;
    [_myScrollView addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(0, title1.bottom+30*PROPORTION750, AL_DEVICE_WIDTH, 25*PROPORTION750)];
    title2.text = @"保险需进行真实姓名和身份证号登记";
    //    title2.textColor = [UIColor colorWithHexString:@"1aad19"];
    title2.font = SYSF750(25);
    title2.textAlignment = NSTextAlignmentCenter;
    [_myScrollView addSubview:title2];
    
    [self createNameIdView:title2];
}

-(void)createNameIdView:(UIView *)lastView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, lastView.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 270*PROPORTION750)];
    view.backgroundColor = [UIColor whiteColor];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 15.0f*PROPORTION750;
    [_myScrollView addSubview:view];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, view.width-40*PROPORTION750, 30*PROPORTION750)];
    _nameTF.placeholder = @"真实姓名";
    [view addSubview:_nameTF];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 89*PROPORTION750, view.width, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [view addSubview:line];
    
    _IdTF = [[UITextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, 120*PROPORTION750, view.width-40*PROPORTION750, 30*PROPORTION750)];
    _IdTF.placeholder = @"身份证号";
    [view addSubview:_IdTF];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 179*PROPORTION750, view.width, 2*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [view addSubview:line1];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(20*PROPORTION750, 210*PROPORTION750, view.width-40*PROPORTION750, 30*PROPORTION750)];
    _phoneTF.placeholder = @"手机号码";
    [view addSubview:_phoneTF];
    
    [self createXYView:view];
}


-(void)createXYView:(UIView *)lastView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, lastView.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 210*PROPORTION750)];
    view.backgroundColor = [UIColor whiteColor];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 15.0f*PROPORTION750;
    [_myScrollView addSubview:view];
    
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 460*PROPORTION750, 30*PROPORTION750)];
//    title.text = @"《小马出行免费乘车意外险协议》";
//    title.textColor = [UIColor colorWithHexString:@"1aad19"];
//    title.font = SYSF750(30);
//    title.textAlignment = NSTextAlignmentLeft;
//    [view addSubview:title];
//    
//    UIButton *gouBT = [[UIButton alloc] initWithFrame:CGRectMake(view.width-220*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
//    [gouBT setImage:[UIImage imageNamed:@"ckunselected"] forState:UIControlStateNormal];
//    [gouBT setImage:[UIImage imageNamed:@"ckselected"] forState:UIControlStateSelected];
//    [gouBT setSelected:YES];
//    [view addSubview:gouBT];
//    
//    UILabel *acceptLB = [[UILabel alloc] initWithFrame:CGRectMake(gouBT.right+10*PROPORTION750, gouBT.top, 400*PROPORTION750, 30*PROPORTION750)];
//    acceptLB.text = @"我已同意";
//    acceptLB.textAlignment = NSTextAlignmentLeft;
//    acceptLB.font = SYSF750(25);
//    [view addSubview:acceptLB];
//    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 89*PROPORTION750, view.width, 2*PROPORTION750)];
//    line.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
//    [view addSubview:line];
    
    
    NSArray *array = @[@"保险期限：自乘车之日起，当天有效；",@"保险责任：驾驶机动车，乘坐机动车期间；",@"保险金额：意外事故最高可达80万元赔偿；"];
    
    for (int i = 0; i < 3; i++)
    {
        UILabel *orderNum = [[UILabel alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750+60*PROPORTION750*i, 30*PROPORTION750, 30*PROPORTION750)];
        orderNum.backgroundColor = [UIColor colorWithHexString:@"1aad19"];
        orderNum.clipsToBounds = YES;
        orderNum.layer.cornerRadius = 15*PROPORTION750;
        orderNum.text = [NSString stringWithFormat:@"%d", i+1];
        orderNum.textColor = [UIColor whiteColor];
        orderNum.font = SYSF750(25);
        orderNum.textAlignment = NSTextAlignmentCenter;
        [view addSubview:orderNum];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(orderNum.right+10*PROPORTION750, 30*PROPORTION750+60*PROPORTION750*i, 650*PROPORTION750, 30*PROPORTION750)];
        content.text = array[i];
        //        content.textColor = [UIColor whiteColor];
        content.font = SYSF750(25);
        content.textAlignment = NSTextAlignmentLeft;
        [view addSubview:content];
    }
    
    [self createSaveBtn:view];
    
}


-(void)createSaveBtn:(UIView *)lastView
{
    UIButton *saveBT = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, lastView.bottom+50*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 90*PROPORTION750)];
    saveBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [saveBT setTitle:@"保存" forState:UIControlStateNormal];
    saveBT.titleLabel.font = SYSF750(40);
    saveBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    saveBT.clipsToBounds = YES;
    saveBT.layer.cornerRadius = 15.0f*PROPORTION750;
    saveBT.tag = 101;
    [saveBT addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_myScrollView addSubview:saveBT];
    
    if (saveBT.bottom > AL_DEVICE_HEIGHT)
    {
        _myScrollView.contentSize = CGSizeMake(AL_DEVICE_WIDTH, saveBT.bottom);
    }
    else
    {
        _myScrollView.contentSize = CGSizeMake(AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT+1);
    }
    
}


-(void)buttonClickEvent:(UIButton *)button
{
    [_nameTF resignFirstResponder];
    [_IdTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
    if (![Regular checkUserName:_nameTF.text])
    {
        [self toast:@"姓名填写错误"];
        return;
    }
    
    if (![Regular validateIdentityCard:_IdTF.text])
    {
        [self toast:@"身份证号填写错误"];
        return;
    }
    
    if (![Regular isMobileNumber:_phoneTF.text])
    {
        [self toast:@"手机号填写错误"];
        return;
    }
    
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _nameTF.text, @"passenger_name",
                                   _IdTF.text, @"passenger_number",
                                   _phoneTF.text, @"passenger_phone",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/passenger_add" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            [self toast:@"提交成功"];
            [self performSelector:@selector(saveSucc) withObject:nil afterDelay:1.5];
        }
        else if (code == 300)
        {
            [self toast:@"身份认证已过期"];
            [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
        }
        else if (code == 400)
        {
            [self toast:msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)saveSucc
{
    self.SuccBlock();
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)gotoCKMainViewController
{
//    ChengKeMainViewController *viewController = [[ChengKeMainViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
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
