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

@interface CKOrderDetailViewController ()<OrderDetailDelegate,OrderDetailBaseViewDelgate,PopAleatViewDelegate,AlertClassDelegate,UpCommenViewDelegate>

@property (nonatomic, strong) OrderDetailBaseView *detailView;

@property (nonatomic, strong) OrderDetailModel *orderDetailModel;

@end

@implementation CKOrderDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
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
    
    self.topTitle = @"订单详情";
//    self.mapView.hidden = true;
//    OrderDetailBaseView *view = [OrderDetailBaseView orderDetailViewWithType:OrederStatusHadCar];
//    [self.view addSubview:view];
    
    
//    _detailView = [[OrderDetailView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-475*PROPORTION750-64, 690*PROPORTION750, 465*PROPORTION750)];
//    _detailView.delegate = self;
//    [self.view addSubview:_detailView];
//    
//    headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(300*PROPORTION750, _detailView.top-45*PROPORTION750, 150*PROPORTION750, 150*PROPORTION750)];
//    headImgView.clipsToBounds = YES;
//    headImgView.layer.cornerRadius = 75*PROPORTION750;
//    headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
//    headImgView.layer.borderWidth = 8*PROPORTION750;
//    headImgView.image = [UIImage imageNamed:@"default"];
//    [self.view addSubview:headImgView];
//    
//    carNumLB = [[UILabel alloc] initWithFrame:CGRectMake(300*PROPORTION750, _detailView.top+85*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
//    carNumLB.backgroundColor = [UIColor whiteColor];
//    carNumLB.text = _orderDetailModel.carCode;
//    carNumLB.font = SYSF750(20);
//    carNumLB.textAlignment = NSTextAlignmentCenter;
//    carNumLB.clipsToBounds = YES;
//    carNumLB.layer.cornerRadius = 10*PROPORTION750;
//    carNumLB.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
//    carNumLB.layer.borderWidth = 1.0f;
//    [self.view addSubview:carNumLB];
    
}

-(void)leftBtn:(UIButton *)button{
    [self dismissViewControllerAnimated:true completion:nil];
    [self.navigationController popViewControllerAnimated:true];
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
    self.topTitle = model.orderStatus_;
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
        _detailView = [OrderDetailBaseView orderDetailViewWithType:[model.orderStatus integerValue]];
        [_detailView setModel:_orderDetailModel];
        _detailView.delegate = self;
        [self.view addSubview:_detailView];
    }
//    switch ([model.orderStatus integerValue]) {
//        case 0:{
//            if ([model.orderStatus_ isEqualToString:@"系统取消"]) {
//                _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusSystemCancle];
//                [_detailView setModel:_orderDetailModel];
//                _detailView.delegate = self;
//                [self.view addSubview:_detailView];
//            }else{
//                _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusNoPay];
//                [_detailView setModel:_orderDetailModel];
//                _detailView.delegate = self;
//                [self.view addSubview:_detailView];
//            }
//        }
//            break;
//        case 10:{
//            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusCancle];
//            [_detailView setModel:_orderDetailModel];
//            _detailView.delegate = self;
//            [self.view addSubview:_detailView];
//        }
//            break;
//        case 20:{
//            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusRefund];
//            [_detailView setModel:_orderDetailModel];
//            _detailView.delegate = self;
//            [self.view addSubview:_detailView];
//        }
//            break;
//            
//        case 25:{
//            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusCarPay];
//            [_detailView setModel:_orderDetailModel];
//            _detailView.delegate = self;
//            [self.view addSubview:_detailView];
//        }
//            break;
//        case 30:{
//            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusHadPay];
//            [_detailView setModel:_orderDetailModel];
//            _detailView.delegate = self;
//            [self.view addSubview:_detailView];
//        }
//            break;
//        case 40:{
//            _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusHadCar];
//            [_detailView setModel:_orderDetailModel];
//            _detailView.delegate = self;
//            [self.view addSubview:_detailView];
//        }
//            break;
//        case 50:{
//            if ([_orderDetailModel.is_pj isEqualToString:@"1"]) {
//                _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusHadCommed];
//                [_detailView setModel:_orderDetailModel];
//                _detailView.delegate = self;
//                [self.view addSubview:_detailView];
//            }else{
//                _detailView = [OrderDetailBaseView orderDetailViewWithType:OrederStatusFinished];
//                [_detailView setModel:_orderDetailModel];
//                _detailView.delegate = self;
//                [self.view addSubview:_detailView];
//            }
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    self.topTitle = _orderDetailModel.orderStatus;
//    self.startAnnotation.subtitle = _orderDetailModel.startPlace.address;
//    self.startAnnotation.coordinate = _orderDetailModel.startPlace.location;
//    self.endAnnotation.subtitle = _orderDetailModel.endPlace.address;
//    self.endAnnotation.coordinate = _orderDetailModel.endPlace.location;
//    [self getMapViewVisbleRect];
//    
//    _detailView.orderDetailModel = _orderDetailModel;
//    carNumLB.text = _orderDetailModel.carCode;
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
        [self phoneAlertView:@"400-966-3655"];
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

    }else if ([title isEqualToString:@"联系司机"]){
        [self phoneAlertView:_orderDetailModel.driverPhone];
    }else if ([title isEqualToString:@"去评价"]){
        UpCommenView *view = [[UpCommenView alloc] init];
        view.delegate = self;
    }else if ([title isEqualToString:@"分享行程"]){
        ShareView *shareView = [[ShareView alloc] init];
        shareView.shareBlock = ^(NSInteger flag){
            [self shareWebPageToPlatformType:flag];
        };
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
    MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"常见问题" urlString:@"https://m.xiaomachuxing.com/index/cproblem#coupon"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://m.xiaomachuxing.com";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用 小马出行" descr:@"欢迎使用 小马出行 优惠 便捷 一键即达！" thumImage:[UIImage imageNamed:@"default"]];
    //设置网页地址
    shareObject.webpageUrl = @"https://m.xiaomachuxing.com";
    
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


//计算地图显示区域
//-(void)getMapViewVisbleRect{
//    BMKMapPoint point1 = BMKMapPointForCoordinate(_orderDetailModel.startPlace.location);
//    BMKMapPoint point2 = BMKMapPointForCoordinate(_orderDetailModel.endPlace.location);
//    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
//    
//    //这个数组就是百度地图比例尺对应的物理距离，其中2000000对应的比例是3，5对应的是21；可能有出入可以根据情况累加
//    float zoomLe = 0.00;
//    NSArray *zoomLevelArr = [[NSArray alloc]initWithObjects:@"2000000", @"1000000", @"500000", @"200000", @"100000", @"50000", @"25000", @"20000", @"10000", @"5000", @"2000", @"1000", @"500", @"200", @"100", @"50", @"20", @"10", @"5", nil];
//    for (int j=0; j<zoomLevelArr.count; j++){
//        if (j + 1 < zoomLevelArr.count){
//            if (distance < [zoomLevelArr[j] intValue] && distance > [zoomLevelArr[j+1] intValue] ){
//                zoomLe = j+6.4;
//                break;
//            }
//        }
//    }
//    BMKMapStatus *status = [[BMKMapStatus alloc] init];
//    status.fLevel = zoomLe;
//    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, 450*PROPORTION750);
//    status.targetGeoPt = CLLocationCoordinate2DMake((_orderDetailModel.startPlace.location.latitude+_orderDetailModel.endPlace.location.latitude)/2,
//                                                    (_orderDetailModel.startPlace.location.longitude+_orderDetailModel.endPlace.location.longitude)/2);
//    [self.mapView setMapStatus:status withAnimation:YES];
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
