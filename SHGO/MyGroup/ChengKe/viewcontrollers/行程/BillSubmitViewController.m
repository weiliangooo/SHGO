//
//  BillSubmitViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/7/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "BillSubmitViewController.h"
#import "UIImage+ScalImage.h"
#import "PayViewController.h"

@interface BillSubmitViewController ()
{
    double price;
    
    UIButton *btn1;
    UIButton *btn2;
    NSInteger topSelect;
    NSInteger payType;
}

@property (nonatomic, strong) UIScrollView *myScrollView;

@end

@implementation BillSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = @"按行程开票";
    self.type = 3;
    [self.rightBtn setTitle:@"开票说明" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    price = 0.00;
    for (int i = 0; i < _dataArray.count; i++) {
        price = price + [_dataArray[i].money doubleValue];
    }
    
    topSelect = 1;
    payType = 100;
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64-120*PROPORTION750)];
    [self.view addSubview:_myScrollView];
    
    UIButton *_payBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, AL_DEVICE_HEIGHT-64-120*PROPORTION750, 710*PROPORTION750, 100*PROPORTION750)];
    _payBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    _payBtn.clipsToBounds = YES;
    _payBtn.layer.cornerRadius = 15*PROPORTION750;
    [_payBtn setTitle:@"提交" forState:UIControlStateNormal];
    _payBtn.titleLabel.font = SYSF750(35);
    _payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_payBtn addTarget:self action:@selector(subBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBtn];
    
    [self billDetailView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardPresent:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//发票详情
-(void)billDetailView{
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 25*PROPORTION750)];
    titleLb.text = @"发票详情";
    titleLb.font = SYSF750(25);
    titleLb.textAlignment = NSTextAlignmentLeft;
    [self.myScrollView addSubview:titleLb];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 85*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 900*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10*PROPORTION750;
    backView.clipsToBounds = true;
    [self.myScrollView addSubview:backView];
    NSString *priceS = [NSString stringWithFormat:@"%.2f元", price];
    NSArray *titles = @[@"抬头类型", @"发票抬头", @"纳税人识别号", @"发票内容", @"发票金额", @"备注说明", @"地址", @"电话", @"开户行", @"账号"];
    NSArray *details = @[@"", @"请填写发票抬头", @"请填写纳税人识别号", @"服务费", priceS, @"请填写备注说明", @"请填写注册地址", @"请填写注册电话", @"请填写开户银行", @"请填写银行账号"];
    for (int i = 0; i < 10; i++) {
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750+90*PROPORTION750*i, 210*PROPORTION750, 30*PROPORTION750)];
        titleLb.text = titles[i];
        titleLb.font = SYSF750(30);
        titleLb.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:titleLb];
        if (i == 0) {
            btn1 = [[UIButton alloc] initWithFrame:CGRectMake(titleLb.right, 25*PROPORTION750, 180*PROPORTION750, 40*PROPORTION750)];
            [btn1 setTitle:@"公司抬头" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.titleLabel.font = SYSF750(25);
            btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 10*PROPORTION750, 0, 0);
            [btn1 setImage:[[UIImage imageNamed:@"ckunselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
            [btn1 setImage:[[UIImage imageNamed:@"ckselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateSelected];
            [btn1 addTarget:self action:@selector(topBtnsClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn1.selected = true;
            [backView addSubview:btn1];
            
            btn2 = [[UIButton alloc] initWithFrame:CGRectMake(btn1.right, 25*PROPORTION750, 180*PROPORTION750, 40*PROPORTION750)];
            [btn2 setTitle:@"个人抬头" forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn2.titleLabel.font = SYSF750(25);
            btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 10*PROPORTION750, 0, 0);
            [btn2 setImage:[[UIImage imageNamed:@"ckunselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
            [btn2 setImage:[[UIImage imageNamed:@"ckselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateSelected];
            [btn2 addTarget:self action:@selector(topBtnsClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn2.selected = false;
            [backView addSubview:btn2];
        }else {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLb.right, 30*PROPORTION750+90*PROPORTION750*i, 450*PROPORTION750, 30*PROPORTION750)];
            textField.tag = i;
            textField.textColor = [UIColor colorWithHexString:@"999999"];
            textField.font = SYSF750(25);
            textField.textAlignment = NSTextAlignmentLeft;
            [backView addSubview:textField];
            if(i == 3 || i == 4){
                textField.enabled = false;
                textField.textColor = [UIColor colorWithHexString:@"#18ae14"];
                textField.text = details[i];
            }else{
                textField.placeholder = details[i];
            }
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750+90*PROPORTION750*i, backView.width, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [backView addSubview:line];
    }
    
    [self messageView:backView];
}

//收件信息
-(void)messageView:(UIView *)lastView{
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, lastView.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 25*PROPORTION750)];
    titleLb.text = @"收件信息";
    titleLb.font = SYSF750(25);
    titleLb.textAlignment = NSTextAlignmentLeft;
    [self.myScrollView addSubview:titleLb];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, lastView.bottom+85*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 270*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10*PROPORTION750;
    backView.clipsToBounds = true;
    [self.myScrollView addSubview:backView];
    
    NSArray *titles = @[@"收件人", @"联系电话", @"收件地址"];
    NSArray *details = @[@"填写收件人", [MyHelperNO getMyMobilePhone], @"填写详细地址"];
    for (int i = 0; i < 3; i++) {
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750+90*PROPORTION750*i, 210*PROPORTION750, 30*PROPORTION750)];
        titleLb.text = titles[i];
        titleLb.font = SYSF750(30);
        titleLb.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:titleLb];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLb.right, 30*PROPORTION750+90*PROPORTION750*i, 450*PROPORTION750, 30*PROPORTION750)];
        textField.tag = i + 10;
        textField.textColor = [UIColor colorWithHexString:@"999999"];
        textField.font = SYSF750(25);
        textField.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:textField];
        if(i == 1){
            textField.enabled = false;
            textField.textColor = [UIColor blackColor];
            textField.text = details[i];
        }else{
            textField.placeholder = details[i];
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750+90*PROPORTION750*i, backView.width, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [backView addSubview:line];
    }
    if (price < 500) {
        [self payView:backView];
    }else{
        _myScrollView.contentSize = CGSizeMake(AL_DEVICE_WIDTH, backView.bottom+20*PROPORTION750);
    }
}

-(void)payView:(UIView *)lastView{
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, lastView.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 25*PROPORTION750)];
    titleLb.text = @"开票不足500元，需支付邮费";
    titleLb.font = SYSF750(25);
    titleLb.textAlignment = NSTextAlignmentLeft;
    [self.myScrollView addSubview:titleLb];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, lastView.bottom+85*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 270*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10*PROPORTION750;
    backView.clipsToBounds = true;
    [self.myScrollView addSubview:backView];
    
    NSArray *pics = @[@"wchat_share", @"alipay", @"cPay"];
    NSArray *details = @[@"微信（全国10元，邮费发票会一同邮寄）", @"支付宝（全国10元，邮费发票会一同邮寄）", @"到付（全国10元）"];
    for(int i = 0; i < 3; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 25*PROPORTION750+90*PROPORTION750*i, 40*PROPORTION750, 40*PROPORTION750)];
        imageView.image = [UIImage imageNamed:pics[i]];
        [backView addSubview:imageView];
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+30*PROPORTION750, 30*PROPORTION750+90*PROPORTION750*i, 540*PROPORTION750, 30*PROPORTION750)];
        titleLb.text = details[i];
        titleLb.font = SYSF750(25);
        titleLb.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:titleLb];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(backView.right-70*PROPORTION750, 25*PROPORTION750+90*PROPORTION750*i, 40*PROPORTION750, 40*PROPORTION750)];
        btn.tag = 100+i;
        [btn setImage:[[UIImage imageNamed:@"ckunselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:@"ckselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(payTypeBtnsClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
        if (i == 0) {
            btn.selected = true;
        }

    }
    
    _myScrollView.contentSize = CGSizeMake(AL_DEVICE_WIDTH, backView.bottom+20*PROPORTION750);
}

-(void)subBtnClicked{
    
    NSString *ttlx;
    if (topSelect == 1) {
        ttlx = @"公司抬头";
    }else{
        ttlx = @"个人抬头";
    }
    
    UITextField *tf1 = [self.view viewWithTag:1];
    if (tf1.text.length == 0) {
        [self toast:@"请填写发票抬头"];
        return;
    }
    UITextField *tf2 = [self.view viewWithTag:2];
    if (tf2.text.length == 0) {
        [self toast:@"请填写纳税识别号"];
        return;
    }
    UITextField *tf3 = [self.view viewWithTag:5];
    //    if (tf3.text.length == 0) {
    //        [self toast:@"请填写纳税识别号"];
    //    }
    UITextField *tf6 = [self.view viewWithTag:6];
    if (tf6.text.length == 0) {
        [self toast:@"请填写注册地址"];
        return;
    }
    UITextField *tf7 = [self.view viewWithTag:7];
    if (tf7.text.length == 0) {
        [self toast:@"请填写电话"];
        return;
    }
    UITextField *tf8 = [self.view viewWithTag:8];
    if (tf8.text.length == 0) {
        [self toast:@"请填写开户行"];
        return;
    }
    UITextField *tf9 = [self.view viewWithTag:9];
    if (tf9.text.length == 0) {
        [self toast:@"请填写账号"];
        return;
    }
    UITextField *tf10 = [self.view viewWithTag:10];
    if (tf10.text.length == 0) {
        [self toast:@"请填写收件人"];
        return;
    }
    UITextField *tf11 = [self.view viewWithTag:11];
    
    UITextField *tf12 = [self.view viewWithTag:12];
    if (tf12.text.length == 0) {
        [self toast:@"请填写收件地址"];
        return;
    }
    
    NSString *ids = @"";
    for (int i = 0 ; i < _dataArray.count; i++) {
        if (i == 0) {
            ids = _dataArray[i].common_id;
        }else{
            ids = [NSString stringWithFormat:@"%@_%@", ids, _dataArray[i].common_id];
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:ttlx, @"tt_lx",
                                tf1.text, @"fptt",
                                tf2.text, @"sbh",
                                tf6.text, @"address",
                                tf7.text, @"phone",
                                tf8.text, @"bank",
                                tf9.text, @"account",
                                tf10.text, @"recive_user",
                                tf11.text, @"recive_phone",
                                tf12.text, @"recive_address",
                                [MyHelperNO getUid], @"uid",
                                [MyHelperNO getMyToken], @"token",
                                ids, @"id",
                                tf3.text, @"context",nil];
    
    [self post:@"user/app_bill" withParam:dic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200){
            NSString *urlS = @"";
            if (payType == 100) {
                urlS = @"";
            }else if (payType == 101){
                urlS = @"user/ali_pay";
            }
            NSMutableDictionary *aDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[responseObject objectForKey:@"data"] stringForKey:@"list"], @"bill_sn",
                                         [MyHelperNO getUid], @"uid",
                                         [MyHelperNO getMyToken], @"token", nil];
            [self post:urlS withParam:aDic success:^(id responseObject) {
                int code = [responseObject intForKey:@"status"];
                NSLog(@"%@", responseObject);
                NSString *msg = [responseObject stringForKey:@"msg"];
                if (code == 200){
                    [[PayViewController shareManager] zhifubaoInit:responseObject];
//                    UIAlertController *viewController = [UIAlertController alertControllerWithTitle:@"" message:@"您已成功开具行程发票，我们将在您申请提交完成后最迟3个工作日内寄出。请注意查收。\n如有疑问请拨打：400-966-3655" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                        
//                    }];
//                    [viewController addAction:sureBtn];
//                    [self presentViewController:viewController animated:true completion:nil];
                }else if (code == 300){
                    
                }else if (code == 400){
                    [self toast:msg];
                }
                
            } failure:^(NSError *error) {
                
            }];
//            UIAlertController *viewController = [UIAlertController alertControllerWithTitle:@"" message:@"您已成功开具行程发票，我们将在您申请提交完成后最迟3个工作日内寄出。请注意查收。\n如有疑问请拨打：400-966-3655" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//            [viewController addAction:sureBtn];
//            [self presentViewController:viewController animated:true completion:nil];
        }else if (code == 300){
            
        }else if (code == 400){
            [self toast:msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
   
}


//公司抬头 个人抬头按钮点击
-(void)topBtnsClicked:(UIButton *)button{
    if (button == btn1) {
        btn1.selected = true;
        btn2.selected = false;
        topSelect = 1;
    }else{
        btn1.selected = false;
        btn2.selected = true;
        topSelect = 2;
    }
}

//支付类型按钮点击
-(void)payTypeBtnsClicked:(UIButton *)button{
    payType = button.tag;
    for (int i = 100 ; i < 103; i++) {
        if (i == payType) {
            UIButton *btn = [self.view viewWithTag:i];
            btn.selected = true;
        }else{
            UIButton *btn = [self.view viewWithTag:i];
            btn.selected = false;
        }
    }
}

///监听当前键盘出现 跟消失
-(void)keyBoardPresent:(NSNotification *)notification{
    CGRect boardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [_myScrollView setContentSize:CGSizeMake(_myScrollView.contentSize.width, _myScrollView.contentSize.height+boardFrame.size.height)];
//    if (keyBoardFrame.origin.y < _pjTextView.bottom+AL_DEVICE_HEIGHT-845*PROPORTION750-64){
//        [UIView animateWithDuration:1.0f animations:^{
//            self.frame = CGRectMake(30*PROPORTION750, -(-keyBoardFrame.origin.y+_pjTextView.bottom+150*PROPORTION750), 690*PROPORTION750, 825*PROPORTION750);
//        }];
//    }
}

-(void)keyBoardDismiss:(NSNotification *)notification{
    CGRect boardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [_myScrollView setContentSize:CGSizeMake(_myScrollView.contentSize.width, _myScrollView.contentSize.height-boardFrame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
