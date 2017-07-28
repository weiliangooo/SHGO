//
//  CKOrderDetailViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKOrderDetailViewController.h"
#import "OrderDetailView.h"
#import "OrderDetailModel.h"
#import "OrderPriceDetailViewController.h"
#import "OrderPriceModel.h"
#import "ShareView.h"
#import "OrderDetailBaseView.h"

#import <UMSocialCore/UMSocialCore.h>
#import "PopAleatView.h"
#import "ResonForCancleViewController.h"
#import "CancleOrderAlertView.h"
#import "PayViewController.h"
#import "RefundView.h"

#import "UpCommenView.h"

#import "MyWebViewController.h"
#import "UIImage+ScalImage.h"
#import "ComplaintViewController.h"

@interface CKOrderDetailViewController ()<OrderDetailDelegate,OrderDetailBaseViewDelgate,PopAleatViewDelegate,AlertClassDelegate,UpCommenViewDelegate>
{
    BOOL isFirstLoad;
}
@property (nonatomic, strong) OrderDetailBaseView *detailView;

@property (nonatomic, strong) OrderDetailModel *orderDetailModel;

@end

@implementation CKOrderDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 2;
    self.leftBtn.frame = CGRectMake(0, 0, 38*PROPORTION750, 30*PROPORTION750);
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20*PROPORTION750, 0, 0);
    [self.leftBtn setImage:[UIImage imageNamed:@"rowback"] forState:UIControlStateNormal];
    self.rightBtn.frame = CGRectMake(0, 0, 35*PROPORTION, 35*PROPORTION);
    [self.rightBtn setImage:[[UIImage imageNamed:@"what_right"] scaleImageByWidth:35*PROPORTION750] forState:UIControlStateNormal];
    
    self.topTitle = _myTitle;
    isFirstLoad = true;

    if ([_myTitle isEqualToString:@"待付款"]) {
        //获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
        [center addObserver:self selector:@selector(zhifubaoNotice:) name:@"zhifubaonotice" object:nil];
        [center addObserver:self selector:@selector(weixinNotice:) name:@"weixinnotice" object:nil];
    }
}

-(void)leftBtn:(UIButton *)button{
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}

-(void)loadData{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _order_sn, @"common_id",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"order/ordercurrent" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
            self.orderDetailModel = [[OrderDetailModel alloc] initWithData:dic];
            [self refreshData];
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

-(void)refreshData{
    if (_detailView) {
        [_detailView removeFromSuperview];
    }
    ckModel *model = [[ckModel alloc] init];
    model = _orderDetailModel.ckMsgs[0];
    if (isFirstLoad) {
        isFirstLoad = false;
    }else{
        self.topTitle = model.orderStatus_;
    }
    
    if (![model.orderStatus_ isEqualToString:@"待付款"]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    if ([model.orderStatus integerValue] == 0) {
        if ([model.orderStatus_ isEqualToString:@"系统取消"]) {
            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusSystemCancle];
            [_detailView setModel:_orderDetailModel];
            _detailView.delegate = self;
            [self.view addSubview:_detailView];
        }else{
            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusNoPay];
            [_detailView setModel:_orderDetailModel];
            _detailView.delegate = self;
            [self.view addSubview:_detailView];
        }
    }else if ([model.orderStatus integerValue] == 50){
        if ([_orderDetailModel.is_pj isEqualToString:@"1"]) {
            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusHadCommed];
            [_detailView setModel:_orderDetailModel];
            _detailView.delegate = self;
            [self.view addSubview:_detailView];
        }else{
            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusFinished];
            [_detailView setModel:_orderDetailModel];
            _detailView.delegate = self;
            [self.view addSubview:_detailView];
        }
    }else{
        if ([model.orderStatus integerValue] <= 30 && _orderDetailModel.driverPhone.length > 5 ) {
            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusHadSend];
            [_detailView setModel:_orderDetailModel];
            _detailView.delegate = self;
            [self.view addSubview:_detailView];
        }else{
            _detailView = [OrderDetailBaseView orderDetailViewWithType:[model.orderStatus integerValue]];
            [_detailView setModel:_orderDetailModel];
            _detailView.delegate = self;
            [self.view addSubview:_detailView];
        }
       
    }
}

#pragma --mark orderDetailBaseView delegate
-(void)OrderDetailBaseViewClickWithTitle:(NSString *)title{
    if ([title isEqualToString:@"我要付款"]){
        PopAleatView *myPopAV = [[PopAleatView alloc] init];
        [myPopAV setButtonStr1:@"支付宝支付" Str2:@"微信支付"];
        myPopAV.delegate = self;
    }else if ([title isEqualToString:@"取消订单"]){
        [self canCleBtnClickEvent];
    }else if ([title isEqualToString:@"如有其他问题请联系客服"]){
        [self phoneAlertView:@"400-1123-166"];
    }else if ([title isEqualToString:@"乘客信息"]){
        RefundView *view = [[RefundView alloc] init];
        view.dataSource = _orderDetailModel.ckMsgs;
        view.isCheck = true;
    }else if ([title isEqualToString:@"查看明细"]){
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _order_sn, @"common_id",
                                       [MyHelperNO getUid], @"uid",
                                       [MyHelperNO getMyToken], @"token", nil];
        [self post:@"order/price_order" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSLog(@"%@", responseObject);
            NSString *msg = [responseObject stringForKey:@"msg"];
            if (code == 200)
            {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                OrderPriceModel *model = [[OrderPriceModel alloc] initWithData:dic];
                OrderPriceDetailViewController *viewController = [[OrderPriceDetailViewController alloc] initWithOrderPriceModel:model];
                [self.navigationController pushViewController:viewController animated:YES];
                
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
    }else if ([title isEqualToString:@"我要退款"]){
        RefundView *view = [[RefundView alloc] init];
        view.dataSource = _orderDetailModel.ckMsgs;
        view.dataBlock = ^(ckModel *model, UIButton*button){
            NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           model.orderId,@"order_id",
                                           [MyHelperNO getUid], @"uid",
                                           [MyHelperNO getMyToken], @"token", nil];
            [self post:@"order/refund" withParam:reqDic success:^(id responseObject) {
                int code = [responseObject intForKey:@"status"];
                NSString *msg = [responseObject stringForKey:@"msg"];
                NSLog(@"%@", responseObject);
                if (code == 200) {
                    [self loadData];
                    button.backgroundColor = [UIColor colorWithHexString:@"999999"];
                    [button setTitle:@"已退款" forState:UIControlStateNormal];
                }else{
                    [self toast:msg];
                }
            }failure:^(NSError *error) {
                
            }];
        };

    }
    else if ([title isEqualToString:@" 联系司机"]){
        [self phoneAlertView:_orderDetailModel.driverPhone];
    }else if ([title isEqualToString:@"去评价"]){
        UpCommenView *view = [[UpCommenView alloc] init];
        view.delegate = self;
    }else if ([title isEqualToString:@"分享行程"]){
        ShareView *shareView = [[ShareView alloc] init];
        shareView.shareBlock = ^(NSInteger flag){
            [self shareWebPageToPlatformType:flag];
        };
    }else if ([title isEqualToString:@"我要投诉"]){
        ComplaintViewController *viewController = [[ComplaintViewController alloc] init];
        viewController.orderNum = self.order_sn;
        [self.navigationController pushViewController:viewController animated:true];
    }
}

#pragma --mark PopAleatView delegate
-(void)onClick:(UIButton *)sender setbtn:(UIButton *)btn popAleatView:(id)popAleatView{
    if (sender.tag==0){
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _order_sn,@"order_sn",
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
    }else{
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _order_sn,@"order_sn",
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
}

-(void)canCleBtnClickEvent{
    CancleOrderAlertView *alerView = [[CancleOrderAlertView alloc] initWithTipTitle:@"是否需要取消订单" TipImage:nil];
    alerView.delegate =self;
}
#pragma --mark AlertClassDelegate
-(void)AlertClassView:(id)alertView clickIndex:(NSInteger)index{
    [alertView removeFromSuperview];
    if (index == 100){
        ResonForCancleViewController *viewController = [[ResonForCancleViewController alloc] init];
        viewController.orderNum = _order_sn;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    NSLog(@"%d",(int)index);
}


#pragma --mark orderDetailView delegate
-(void)orderDetailView:(OrderDetailView *)orderDetailView ClickEvents:(OrderDetailViewEvent)event inputString:(NSString *)inputString
{
    if (event == OrderDetailViewEventDetail)
    {
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _order_sn, @"common_id",
                                       [MyHelperNO getUid], @"uid",
                                       [MyHelperNO getMyToken], @"token", nil];
        [self post:@"order/price_order" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSLog(@"%@", responseObject);
            NSString *msg = [responseObject stringForKey:@"msg"];
            if (code == 200)
            {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                OrderPriceModel *model = [[OrderPriceModel alloc] initWithData:dic];
                OrderPriceDetailViewController *viewController = [[OrderPriceDetailViewController alloc] initWithOrderPriceModel:model];
                [self.navigationController pushViewController:viewController animated:YES];
                
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
    else if (event == OrderDetailViewEventShare)
    {
        ShareView *shareView = [[ShareView alloc] init];
        shareView.shareBlock = ^(NSInteger flag){
            [self shareWebPageToPlatformType:flag];
        };

    }
}

#pragma upCommendView delegate
-(void)upCommenView:(UpCommenView *)view
             score1:(NSString *)score1
             score2:(NSString *)score2
             score3:(NSString *)score3
             score4:(NSString *)score4
               text:(NSString *)text{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _order_sn, @"order_sn",
                                   score1, @"td",
                                   score2, @"zj",
                                   score3, @"js",
                                   score4, @"sx",
                                   text, @"content",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"order/orderevaluation" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200){
            [self toast:@"感谢您的评价！"];
            [self loadData];
            [view removeFromSuperview];
        }else if (code == 300){
            [self toast:@"身份认证已过期"];
            [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
        }else if (code == 400){
            [self toast:msg];
        }
     
    } failure:^(NSError *error) {
        
    }];
}

-(void)alReLoadData{
    [self loadData];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self hideLoading];
    });
}

-(void)rightBtn:(UIButton *)button{
    MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"常见问题" urlString:@"https://m.xiaomachuxing.com/index/cproblem#order"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"Hi，朋友，送你10元小马出行优惠券，为你约车买单！" descr:@"我一直用小马出行，既经济又便捷舒适，邀你一起来体验，首次乘坐立减10元~" thumImage:[UIImage imageNamed:@"default"]];
    //设置网页地址
    shareObject.webpageUrl =[NSString stringWithFormat:@"https://m.xiaomachuxing.com/qrcode/inviteapp/id/%@", [MyHelperNO getUid]];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
