//
//  CKBookViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookViewController.h"
#import "CKBookView.h"
#import "BookSelectNumPsView.h"
#import "CKDiscoutSelectView.h"
#import "CKSendOrderViewController.h"
#import "CKPayView.h"
#import "CKSureOrderModel.h"
#import "PayViewController.h"
#import "CKOrderDetailViewController.h"
#import "BaseNavViewController.h"

@interface CKBookViewController ()<BMKMapViewDelegate,CKBookViewDelegate,CKPayViewDelegate,DiscoutSelectViewDelegate>
{
    NSString *orderSn;
}
///显示界面
@property (nonatomic, strong)CKBookView *bookView;
///选择优惠界面
@property (nonatomic, strong)CKDiscoutSelectView *ckDiscoutView;
///确认订单界面的model
@property (nonatomic, strong)CKSureOrderModel *sureOrderModel;
///支付界面
@property (nonatomic, strong)CKPayView *payView;
///获取所有的活动
@property (nonatomic, strong)NSMutableArray <ActivityModel *> *allActModels;
///是否是拼车
@property (nonatomic, assign)BOOL isPinCar;
///选中的乘客数
@property (nonatomic, assign)NSInteger numPs;
///当前选择的优惠活动
@property (nonatomic, strong)ActivityModel *stActModel;
///是否是拼车
@property (nonatomic, assign)BOOL isUseWallet;


@end

@implementation CKBookViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"确认订单";
    
    [self getCKsAndActs];
    
    _bookView = [[CKBookView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-570*PROPORTION750-64, AL_DEVICE_WIDTH, 880*PROPORTION750) inputData:_inputData];
    _bookView.delegate = self;
    _bookView.stActModel = _stActModel;
    _bookView.numPs = _numPs;
//    _bookView.ckBookMsgView.delegate = self;
//    _bookView.ckBookMsgView.stCKData = self.ckModels;
//    _bookView.ckBookMsgView.stActModel = self.stActModel;
    [self.view addSubview:_bookView];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(zhifubaoNotice:) name:@"zhifubaonotice" object:nil];
    [center addObserver:self selector:@selector(weixinNotice:) name:@"weixinnotice" object:nil];

    
}

///获取所有活动和乘客 和 设置默认乘客、默认优惠
-(void)getCKsAndActs
{
    NSArray *acts = [NSArray arrayWithArray:[_inputData arrayForKey:@"act"]];
    _allActModels = [NSMutableArray array];
    _stActModel = [[ActivityModel alloc] init];
    for (int i = 0 ; i < acts.count+1; i++){
        ActivityModel *model;
        if (i == 0) {
            NSDictionary *dic = [acts objectAtIndex:i];
            model = [[ActivityModel alloc] initWithInputData:dic];
            _stActModel = model;
        }
        else if (i == acts.count){
            model = [[ActivityModel alloc] initWithInputData:nil];
        }
        else{
            NSDictionary *dic = [acts objectAtIndex:i];
            model = [[ActivityModel alloc] initWithInputData:dic];
        }
        [_allActModels addObject:model];
    }
    _numPs = 1;
    _isUseWallet = false;
    _isPinCar = true;
}

#pragma --mark CKBookView 代理
-(void)CKBookView:(CKBookView *)bookView events:(NSInteger)event{
    
    __block typeof(self) weakSelf = self;
    switch (event) {
        case 99:{
            [self getCKsAndActs];
            _bookView.stActModel = _stActModel;
            _bookView.numPs = _numPs;
        }
            break;
        case 100:{
            [self getCKsAndActs];
            _isPinCar = false;
            _bookView.stActModel = _stActModel;
            _bookView.numPs = _numPs;
        }
            break;
        case 101:{
            BookSelectNumPsView *view = [[BookSelectNumPsView alloc] init];
            view.bookNumPsBlock = ^(NSInteger num){
                weakSelf.numPs = num;
                weakSelf.bookView.numPs = num;
            };
        }
            break;
        case 102:{
            _ckDiscoutView = [[CKDiscoutSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT) data:_allActModels];
            _ckDiscoutView.stActModel = _stActModel;
            _ckDiscoutView.delegate = self;
        }
            break;
        case 103:
            _isUseWallet = true;
            break;
        case 104:
            _isUseWallet = false;
            break;
        case 105:{
            NSString *string = _bookView.APrice;
            _payView = [[CKPayView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
            [_payView.payBtn setTitle:[NSString stringWithFormat:@"确认付款%@",string] forState:UIControlStateNormal];
            _payView.delegate = self;
        }
            break;
            
        default:
            break;
    }
}

#pragma --mark CKPayView 代理
-(void)CKPayViwePayEventsWithFlag:(NSInteger)flag
{
    [_payView removeFromSuperview];
    [self MySureOrderModel:flag];
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _sureOrderModel.up_message,@"message",
                                   _sureOrderModel.up_act_id,@"act_id",
                                   _sureOrderModel.up_type,@"act_type",
                                   _sureOrderModel.up_start_time,@"start_time",
                                   _sureOrderModel.up_banci_id,@"banci_id",
                                   _sureOrderModel.up_start,@"start",
                                   _sureOrderModel.up_start_name,@"start_name",
                                   _sureOrderModel.up_arrive_name,@"arrive_name",
                                   _sureOrderModel.up_arriver,@"arriver",
                                   _sureOrderModel.up_paytype,@"paytype",
                                   _sureOrderModel.up_paytool,@"paytool",
                                   _sureOrderModel.up_passenger,@"passenger_count",
                                   _sureOrderModel.up_use_wallet,@"use_wallet",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    NSString *urlString = _isPinCar?@"choosecar/order_test":@"choosecar/order_vip";
    [self post:urlString withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSString *msg = [responseObject stringForKey:@"msg"];
        NSLog(@"%@", responseObject);
        if (code == 200){//
//            orderSn = [responseObject objectForKey:@"data"];
//            
//            [[PayViewController shareManager] weinxinInit];
        }else if (code == 210){//微信
            orderSn = [responseObject objectForKey:@"data"];
            
//            NSLog(@"%@", [MyHelperNO getIpAddresses]);
            
            NSString *ordNum = [responseObject stringForKey:@"data"];
            NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           ordNum,@"order_sn",
                                           [MyHelperNO getIpAddresses], @"scip",
                                           [MyHelperNO getUid], @"uid",
                                           [MyHelperNO getMyToken], @"token", nil];
            [self post:@"order/wechat_pay" withParam:reqDic success:^(id responseObject) {
                int code = [responseObject intForKey:@"status"];
                NSString *msg = [responseObject stringForKey:@"msg"];
                NSLog(@"%@", responseObject);
                if (code == 200) {
                    [[PayViewController shareManager] weinxinInit:responseObject];
                }else{
                    [self toast:msg];
                }
            }failure:^(NSError *error) {
                
            }];
        }
        else if (code == 220){//支付宝
            orderSn = [responseObject objectForKey:@"data"];
            NSString *ordNum = [responseObject stringForKey:@"data"];
            NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           ordNum,@"order_sn",
                                           [MyHelperNO getUid], @"uid",
                                           [MyHelperNO getMyToken], @"token", nil];
            [self post:@"order/ali_pay" withParam:reqDic success:^(id responseObject) {
                int code = [responseObject intForKey:@"status"];
                NSString *msg = [responseObject stringForKey:@"msg"];
                NSLog(@"%@", responseObject);
                if (code == 200) {
                    [[PayViewController shareManager] zhifubaoInit:responseObject];
                }else{
                    [self toast:msg];
                }
            }failure:^(NSError *error) {
                
            }];
        }
        else if (code == 250){///线下下单成功
            orderSn = [responseObject objectForKey:@"data"];
            [self succToNext];
            
        }else if (code == 260){///钱包支付成功
            orderSn = [responseObject objectForKey:@"data"];
            [self toast:msg];
            [self performSelector:@selector(succToNext) withObject:nil afterDelay:1.5];
        }
        else if (code == 350)
        {///有未付款订单
            [self toast:@"您有一笔未付款订单"];
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                CKOrderDetailViewController *viewController = [[CKOrderDetailViewController alloc] init];
                viewController.order_sn = [responseObject objectForKey:@"data"];
                BaseNavViewController *naviController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
                [self presentViewController:naviController animated:true completion:nil];
            });
        }
        else if (code == 360)
        {///无法下单切换下一班次
            [self toast:@"当前班次无法下单，请重新选择班次！"];
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

#pragma --mark CKDiscoutSelectView 代理
-(void)DiscoutSelectView:(CKDiscoutSelectView *)dicoutView selectResult:(ActivityModel *)model{
    _stActModel = model;
    [dicoutView removeFromSuperview];
    _bookView.stActModel = _stActModel;
}

///生成要提交的model
-(void)MySureOrderModel:(NSInteger)flag
{
    NSDictionary *info = [_inputData objectForKey:@"info"];
    _sureOrderModel = [[CKSureOrderModel alloc] init];
    _sureOrderModel.up_message = @"0";
    _sureOrderModel.up_act_id = _stActModel.actId;
    _sureOrderModel.up_type = _stActModel.actType;
    _sureOrderModel.up_start_time = [_inputData stringForKey:@"unix_zero"];
    _sureOrderModel.up_banci_id = [info stringForKey:@"id"];
    _sureOrderModel.up_start = _startLocal;
    _sureOrderModel.up_start_name = self.ccMsgModel.startPlaceModel.address;
    _sureOrderModel.up_arrive_name = self.ccMsgModel.endPlaceModel.address;
    _sureOrderModel.up_arriver = _endLocal;
    if (flag == 3)
    {
        _sureOrderModel.up_paytype = @"2";
    }
    else
    {
        _sureOrderModel.up_paytype = @"1";
    }
    _sureOrderModel.up_paytool = [NSString stringWithFormat:@"%d", (int)flag];
    _sureOrderModel.up_passenger = [NSString stringWithFormat:@"%d", (int)_numPs];
    _sureOrderModel.up_use_wallet = _isUseWallet?@"1":@"2";
//    if (([_stActModel.actType isEqualToString:@"event"] || [_stActModel.actType isEqualToString:@"extra"]) && ![_stActModel.actId isEqualToString:_sureOrderModel.up_paytype]){
//        [self toast:@"线上优惠仅限线上付款"];
//        return;
//    }
//    
//    if (([_stActModel.actType isEqualToString:@"user_money"] || [_stActModel.actType isEqualToString:@"coupon"]) && ![_sureOrderModel.up_paytype isEqualToString:@"1"]){
//        [self toast:@"线上优惠仅限线上付款"];
//        return;
//    }
}


-(void)zhifubaoNotice:(NSNotification *)obj
{
    
    NSLog(@"obj ======= ======= ===== %@", obj);
    NSString * status = [obj.userInfo stringForKey:@"status"];
    if([status isEqualToString:@"6002"]){//网络连接出错
        [self toast:@"网络连接出错"];
    }
    if([status isEqualToString:@"6001"]){//用户中途取消
        [self toast:@"用户中途取消"];
    }
    if([status isEqualToString:@"9000"]){//成功
        [self toast:@"订单支付成功"];
        [self performSelector:@selector(succToNext) withObject:nil afterDelay:1.5];
        //        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if([status isEqualToString:@"8000"]){//正在处理中
        [self toast:@"正在处理中"];
    }
    if([status isEqualToString:@"4000"]){//订单支付失败
        [self toast:@"订单支付失败"];
        
    }
}
-(void)weixinNotice:(NSNotification *)obj
{
    NSLog(@"obj ======= ======= ===== %@", obj);
    NSString * status = [obj.userInfo stringForKey:@"status"];
    NSString *strMsg;
    //支付返回结果，实际支付结果需要去微信服务器端查询
    switch ([status intValue]) {
        case 0:
            strMsg = @"订单支付成功";
            [self toast:strMsg];
            [self performSelector:@selector(succToNext) withObject:nil afterDelay:1.5];
            //            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case -1:
            strMsg = @"订单支付失败";
            [self toast:strMsg];
            break;
        case -2:
            strMsg = @"用户中途取消";
            [self toast:strMsg];
            break;
        default:
            strMsg = @"未知错误";
            [self toast:strMsg];
            break;
    }
}
-(void)leftBtn:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:true];
}
-(void)succToNext
{
    NSDictionary *info = [_inputData objectForKey:@"info"];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[_inputData stringForKey:@"unix"] integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    CKSendOrderViewController *viewController = [[CKSendOrderViewController alloc] initWithCCMsgModel:self.ccMsgModel];
    viewController.startEndCity = [NSString stringWithFormat:@"%@——>%@", [info stringForKey:@"start_address_name"], [info stringForKey:@"end_address_name"]];
    viewController.startTime = confromTimespStr;
    viewController.orderNum = orderSn;
    [self.navigationController pushViewController:viewController animated:YES];
    
    [_payView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
