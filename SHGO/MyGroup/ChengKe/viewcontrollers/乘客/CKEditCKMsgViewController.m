//
//  CKEditCKMsgViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKEditCKMsgViewController.h"
#import "CKListModel.h"

@interface CKEditCKMsgViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) CKListSingelModel *dataSoure;

@end

@implementation CKEditCKMsgViewController

-(instancetype)initWithData:(CKListSingelModel *)dataSoure
{
    if(self = [super init])
    {
        _dataSoure = dataSoure;
    }
    return self;
}

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
    NSArray *texts = @[_dataSoure.ckName, _dataSoure.ckNumber, _dataSoure.ckPhone];
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
        textTF.delegate = self;
        textTF.text = texts[i];
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
    [button addTarget:self action:@selector(buttonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonClickEvent
{
    for (int i = 100; i < 103; i++)
    {
        UITextField *tf = [self.view viewWithTag:i];
        [tf resignFirstResponder];
    }
    if (![Regular checkUserName:_dataSoure.ckName])
    {
        [self toast:@"姓名填写错误"];
        return;
    }
    
    if (![Regular validateIdentityCard:_dataSoure.ckNumber])
    {
        [self toast:@"身份证号填写错误"];
        return;
    }
    
    if (![Regular isMobileNumber:_dataSoure.ckPhone])
    {
        [self toast:@"手机号填写错误"];
        return;
    }
    
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _dataSoure.ckId, @"id",
                                   _dataSoure.ckName, @"passenger_name",
                                   _dataSoure.ckNumber, @"passenger_number",
                                   _dataSoure.ckPhone, @"passenger_phone",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/passenger_add" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            [self toast:@"修改成功"];
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100)
    {
        _dataSoure.ckName = textField.text;
    }
    else if (textField.tag == 101)
    {
        _dataSoure.ckNumber = textField.text;
    }
    else if (textField.tag == 102)
    {
        _dataSoure.ckPhone = textField.text;
    }
}

-(void)saveSucc
{
    self.SuccBlock();
    [self.navigationController popViewControllerAnimated:YES];
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
