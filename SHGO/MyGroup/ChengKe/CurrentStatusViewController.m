//
//  CurrentStatusViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/12.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CurrentStatusViewController.h"
#import "MyStar.h"
#import "UIImage+ScalImage.h"
#import "StatusViews.h"
#import "CancleOrderAlertView.h"
#import "ResonForCancleViewController.h"
#import "ComplaintViewController.h"
#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>

@interface CurrentStatusViewController ()<S_EndViewDelegate,BMKLocationServiceDelegate>
{
    UILabel *DisLabel;
    BOOL isRectVisbel;
    BMKUserLocation *myLocation;
}
@property (nonatomic, strong)BMKLocationService *locationService;

@end

@implementation CurrentStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.gesturesEnabled = true;
    self.mapView.zoomEnabledWithTap = false;
    self.mapView.overlookEnabled = false;
    self.mapView.rotateEnabled = false;
    
    if ([_statusModel.order_status isEqualToString:@"30"]) {
        if ([_statusModel.car_id isEqualToString:@"0"]) {
            _curStatus = s_start;
        }else{
            _curStatus = s_waiting;
        }
    }else if ([_statusModel.order_status isEqualToString:@"40"]){
        _curStatus = s_onWay;
    }else if ([_statusModel.order_status isEqualToString:@"50"]){
        _curStatus = s_end;
    }
//    _curStatus = s_onWay;
    [self CreateUI];
}

/********************** 刷新当前ui **********************/
-(void)refreshCurUI:(StatusModel *)model{
    _statusModel = model;
    if ([_statusModel.order_status isEqualToString:@"30"]) {
        if ([_statusModel.car_id isEqualToString:@"0"]) {
            _willStatus = s_start;
        }else{
            _willStatus = s_waiting;
        }
    }else if ([_statusModel.order_status isEqualToString:@"40"]){
        _willStatus = s_onWay;
    }else if ([_statusModel.order_status isEqualToString:@"50"]){
        _willStatus = s_end;
    }
    
    if (_curStatus != _willStatus) {
        _curStatus = _willStatus;
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
        self.mapView.zoomLevel = 17;
        self.mapView.delegate = self;
        self.view = self.mapView;
        [self CreateUI];
    }else{
        if (_curStatus == s_waiting) {
            self.driverAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.local];
            BMKMapPoint point1 = BMKMapPointForCoordinate([MyHelperTool locationStringToLocationCoordinate:_statusModel.local]);
            BMKMapPoint point2 = BMKMapPointForCoordinate(myLocation.location.coordinate);
            CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
            if (distance/1000 < 1) {
                DisLabel.text = [NSString stringWithFormat:@"1分钟|距离%.0f米", distance];
            }else{
                DisLabel.text = [NSString stringWithFormat:@"%d分钟|距离%.0f公里",(int)distance/5000*6, distance/1000];
            }
            [DisLabel sizeToFit];
            DisLabel.center = CGPointMake(200*PROPORTION750/2, 50*PROPORTION750/2);
        }
    }
}

-(void)CreateUI{
    [self.mapView removeAnnotation:self.startAnnotation];
    [self.mapView removeAnnotation:self.endAnnotation];
    switch (_curStatus) {
            
        case s_start:{
            isRectVisbel = false;
            self.startAnnotation = [[BMKPointAnnotation alloc]init];
            self.startAnnotation.title = @"起点";
            self.startAnnotation.subtitle = _statusModel.se;
            self.startAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.s];
            [self.mapView addAnnotation:self.startAnnotation];
            
            self.endAnnotation = [[BMKPointAnnotation alloc]init];
            self.endAnnotation.title = @"终点";
            self.endAnnotation.subtitle = _statusModel.ee;
            self.endAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.e];
            [self.mapView addAnnotation:self.endAnnotation];
            
            [self getVisbleRect:[MyHelperTool locationStringToLocationCoordinate:_statusModel.s] :[MyHelperTool locationStringToLocationCoordinate:_statusModel.e]];
            
            ((YHBaseViewController *)self.parentViewController).topTitle = @"等待派单中";
            S_StartView *view = [[S_StartView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-330*PROPORTION750-64, 690*PROPORTION750, 310*PROPORTION750) DataSource:_statusModel];
            view.statusBlock = ^(){
                [self phoneAlertView:@"400-1123-166"];
            };
            [self.view addSubview:view];
        }
            break;
        case s_waiting:{
            isRectVisbel = true;
            self.locationService = [[BMKLocationService alloc] init];
            self.locationService.delegate = self;
            [BMKLocationService setLocationDistanceFilter:10];
            
            self.mapView.showsUserLocation = YES;
            self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
            [self.locationService startUserLocationService];
            
            self.driverAnnotation = [[BMKPointAnnotation alloc]init];
            self.driverAnnotation.title = @"司机位置";
//            self.driverAnnotation.subtitle = _statusModel.ee;
            self.driverAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.local];
            [self.mapView addAnnotation:self.driverAnnotation];
            
//            [self getVisbleRect:[MyHelperTool locationStringToLocationCoordinate:_statusModel.local] :self.mapView.centerCoordinate];
            
            ((YHBaseViewController *)self.parentViewController).topTitle = @"司机正在路上";
            [self addTipView];
            S_WatingView *view = [[S_WatingView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-450*PROPORTION750-64, 690*PROPORTION750, 430*PROPORTION750) DataSource:_statusModel];
            view.statusBlock = ^(NSInteger flag){
                if (flag == 100) {
                    [self phoneAlertView:_statusModel.driver_phone];
                }else if (flag == 200){
                    
                }else{
                    ShareView *shareView = [[ShareView alloc] init];
                    shareView.shareBlock = ^(NSInteger flag){
                        [self shareWebPageToPlatformType:flag];
                    };
                }
            };
            [self.view addSubview:view];
            
            [self addHeadView:view];
        }
            break;
        case s_onWay:{
            isRectVisbel = false;
            self.locationService = [[BMKLocationService alloc] init];
            self.locationService.delegate = self;
//            [BMKLocationService setLocationDistanceFilter:0];
            
            self.mapView.showsUserLocation = YES;
//            self.mapView.userTrackingMode = BMKUserTrackingModeNone;
            [self.locationService startUserLocationService];
            
            self.startAnnotation = [[BMKPointAnnotation alloc]init];
            self.startAnnotation.title = @"起点";
            self.startAnnotation.subtitle = _statusModel.se;
            self.startAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.s];
            [self.mapView addAnnotation:self.startAnnotation];
            
            self.endAnnotation = [[BMKPointAnnotation alloc]init];
            self.endAnnotation.title = @"终点";
            self.endAnnotation.subtitle = _statusModel.ee;
            self.endAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.e];
            [self.mapView addAnnotation:self.endAnnotation];
            
            [self getVisbleRect:[MyHelperTool locationStringToLocationCoordinate:_statusModel.s] :[MyHelperTool locationStringToLocationCoordinate:_statusModel.e]];
            
            ((YHBaseViewController *)self.parentViewController).topTitle = @"行程中";
            [self addTipView];
            S_OnWayView *view = [[S_OnWayView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-350*PROPORTION750-64, 690*PROPORTION750, 330*PROPORTION750) DataSource:_statusModel];
            view.statusBlock = ^(){
                ShareView *shareView = [[ShareView alloc] init];
                shareView.shareBlock = ^(NSInteger flag){
                    [self shareWebPageToPlatformType:flag];
                };
            };
            [self.view addSubview:view];
        
            [self addHeadView:view];
        }
            break;
        case s_end:{
            isRectVisbel = false;
            self.startAnnotation = [[BMKPointAnnotation alloc]init];
            self.startAnnotation.title = @"起点";
            self.startAnnotation.subtitle = _statusModel.se;
            self.startAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.s];
            [self.mapView addAnnotation:self.startAnnotation];
            
            self.endAnnotation = [[BMKPointAnnotation alloc]init];
            self.endAnnotation.title = @"终点";
            self.endAnnotation.subtitle = _statusModel.ee;
            self.endAnnotation.coordinate = [MyHelperTool locationStringToLocationCoordinate:_statusModel.e];
            [self.mapView addAnnotation:self.endAnnotation];
            
            [self getVisbleRect:[MyHelperTool locationStringToLocationCoordinate:_statusModel.s] :[MyHelperTool locationStringToLocationCoordinate:_statusModel.e]];
            
            ((YHBaseViewController *)self.parentViewController).topTitle = @"已完成";
            S_EndView *view = [[S_EndView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-845*PROPORTION750-64, 690*PROPORTION750, 825*PROPORTION750) DataSource:nil];
            view.statusBlock = ^(){
                ComplaintViewController *viewController = [[ComplaintViewController alloc] init];
                viewController.orderNum = _statusModel.order_sn;
                [self.navigationController pushViewController:viewController animated:true];
            };
            view.delegate = self;
            [self.view addSubview:view];
    
            [self addHeadView:view];
        }
            break;
        default:
            break;
    }
}

#pragma mark - BMKLocationService代理方法
-(void)willStartLocatingUser
{
    NSLog(@"开始定位");
}
-(void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败%@", error);
}

/**
 *  定位成功，再次定位的方法(定位成功触发)
 */
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.mapView updateLocationData:userLocation];
    myLocation = userLocation;
    if (isRectVisbel) {
        isRectVisbel = false;
        [self getVisbleRect:[MyHelperTool locationStringToLocationCoordinate:_statusModel.local] :myLocation.location.coordinate];
    }
}

///
-(void)addTipView{
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 20*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 50*PROPORTION750)];
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.clipsToBounds = true;
    tipView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:tipView];
    
    UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-200*PROPORTION750, 50*PROPORTION750)];
    tipLb.text = @"如发现载客人数与合乘人数不符，请及时投诉";
    tipLb.font = SYSF750(20);
    tipLb.textAlignment = NSTextAlignmentCenter;
    [tipView addSubview:tipLb];
    
    UIButton *tipBtn = [[UIButton alloc] initWithFrame:CGRectMake(tipLb.right, 0, 160*PROPORTION750, 50*PROPORTION750)];
    tipBtn.backgroundColor = [UIColor colorWithHexString:@"#17b00e"];
    [tipBtn setTitle:@"我要投诉" forState:UIControlStateNormal];
    [tipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipBtn.titleLabel.font = SYSF750(20);
    [tipBtn addTarget:self action:@selector(tipBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tipView addSubview:tipBtn];
}

-(void)tipBtnClicked:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否确定实载人数与合载人数不符？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _statusModel.order_sn, @"order_sn",
                                       [MyHelperNO getUid], @"uid",
                                       [MyHelperNO getMyToken], @"token", nil];
        [self post:@"index/complaint" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSLog(@"%@", responseObject);
            NSString *msg = [responseObject stringForKey:@"msg"];
            if (code == 200){
                [self toast:@"感谢您的反馈！"];
            }else if (code == 300){
                [self toast:@"身份认证已过期"];
                [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
            }else if (code == 400){
                [self toast:msg];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }];
    [alertController addAction:cancleBtn];
    [alertController addAction:sureBtn];
    [self presentViewController:alertController animated:true completion:nil];
}

-(void)addHeadView:(UIView *)view{
    UILabel *driverNameLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 210*PROPORTION750, 30*PROPORTION750)];
    driverNameLB.text = [NSString stringWithFormat:@"%@师傅",[_statusModel.driver_name substringToIndex:1]];
    driverNameLB.textAlignment = NSTextAlignmentCenter;
    driverNameLB.font = SYSF750(30);
    [view addSubview:driverNameLB];
    
    UILabel *carLB = [[UILabel alloc] initWithFrame:CGRectMake(450*PROPORTION750, 30*PROPORTION750, 210*PROPORTION750, 100*PROPORTION750)];
    carLB.text = _statusModel.car_type;
    carLB.textAlignment = NSTextAlignmentCenter;
    carLB.font = SYSF750(30);
    carLB.numberOfLines = 0;
    [carLB sizeToFit];
    [view addSubview:carLB];
    
    if (_curStatus == s_waiting || _curStatus == s_onWay) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合乘人数：%@人", _statusModel.count]];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#71d77c"] range:NSMakeRange(5, 2)];
        UILabel *numLB = [[UILabel alloc] initWithFrame:CGRectMake(carLB.left, carLB.bottom+10*PROPORTION750, carLB.width, 30*PROPORTION750)];
//        numLB.text = _statusModel.count;
        numLB.attributedText = string;
        numLB.textAlignment = NSTextAlignmentCenter;
        numLB.font = SYSF750(25);
        [numLB sizeToFit];
        [view addSubview:numLB];
    }
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(270*PROPORTION750, -50*PROPORTION750, 150*PROPORTION750, 150*PROPORTION750)];
    headImg.clipsToBounds = true;
    headImg.layer.cornerRadius = 75*PROPORTION750;
    headImg.layer.borderWidth = 5*PROPORTION750;
    headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    [headImg sd_setImageWithURL:[NSURL URLWithString:_statusModel.avatar] placeholderImage:[UIImage imageNamed:@"default"]];
    [view addSubview:headImg];
    
    UILabel *carNumLB = [[UILabel alloc] initWithFrame:CGRectMake(270*PROPORTION750, 80*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
    carNumLB.backgroundColor = [UIColor whiteColor];
    carNumLB.text = _statusModel.car_cp;
    carNumLB.font = FONT750(30);
    carNumLB.textAlignment = NSTextAlignmentCenter;
    carNumLB.layer.shadowOpacity = 0.9;// 阴影透明度
    carNumLB.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    carNumLB.layer.shadowRadius = 3;// 阴影扩散的范围控制
    carNumLB.layer.shadowOffset  = CGSizeMake(1, 1);// 阴影的范围
    [view addSubview:carNumLB];
}

/********************** 刷新当前ui **********************/

-(void)S_EndView:(S_EndView *)view
          score:(NSString *)score
            text:(NSString *)text{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _statusModel.order_sn, @"order_sn",
                                   score, @"td",
                                   score, @"zj",
                                   score, @"js",
                                   score, @"sx",
                                   text, @"content",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"order/orderevaluation" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200){
            [self toast:@"感谢您的评价！"];
//            [self loadData];
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

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]){
        if (annotation == self.startAnnotation){
            BMKAnnotationView *newStart = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"startAnnotation"];
            newStart.image = [UIImage imageNamed:@"starPoint"];   //把大头针换成别的图片
            return newStart;
        }else if (annotation == self.endAnnotation){
            BMKAnnotationView *newStart = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"endAnnotation"];
            newStart.image = [UIImage imageNamed:@"endPoint"];   //把大头针换成别的图片
            return newStart;
        }else{
            BMKAnnotationView *newStart = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"endAnnotation"];
            newStart.image = [UIImage imageNamed:@"driverLoc"];   //把大头针换成别的图片
            DisLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, newStart.width, 50*PROPORTION750)];
            DisLabel.textColor = [UIColor whiteColor];
            DisLabel.textAlignment = NSTextAlignmentCenter;
            DisLabel.font = SYSF750(20);
            [newStart addSubview:DisLabel];
            newStart.centerOffset = CGPointMake(0, -newStart.size.height/2);
            return newStart;
        }
    }
    return nil;
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
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


//-(void)canCleBtnClickEvent{
//    CancleOrderAlertView *alerView = [[CancleOrderAlertView alloc] initWithTipTitle:@"是否需要取消订单" TipImage:nil];
//    alerView.delegate =self;
//}
//
//-(void)AlertClassView:(id)alertView clickIndex:(NSInteger)index{
//    [alertView removeFromSuperview];
//    if (index == 100){
//        ResonForCancleViewController *viewController = [[ResonForCancleViewController alloc] init];
////        viewController.orderNum = _orderNum;
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
//    NSLog(@"%d",(int)index);
//}

-(void)getVisbleRect:(CLLocationCoordinate2D)start
                    :(CLLocationCoordinate2D)end{
    BMKMapPoint point1 = BMKMapPointForCoordinate(start);
    BMKMapPoint point2 = BMKMapPointForCoordinate(end);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    
    //这个数组就是百度地图比例尺对应的物理距离，其中2000000对应的比例是3，5对应的是21；可能有出入可以根据情况累加
    float zoomLe = 0.00;
    NSArray *zoomLevelArr = [[NSArray alloc]initWithObjects:@"2000000", @"1000000", @"500000", @"200000", @"100000", @"50000", @"25000", @"20000", @"10000", @"5000", @"2000", @"1000", @"500", @"200", @"100", @"50", @"20", @"10", @"5", nil];
    for (int j=0; j<zoomLevelArr.count; j++){
        if (j + 1 < zoomLevelArr.count){
            if (distance < [zoomLevelArr[j] intValue] && distance > [zoomLevelArr[j+1] intValue] ){
                zoomLe = j+6;
                break;
            }
        }else{
            zoomLe = 21;
        }
    }
    
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = zoomLe;
    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, 450*PROPORTION750);
    status.targetGeoPt = CLLocationCoordinate2DMake((start.latitude+end.latitude)/2,
                                                    (start.longitude+end.longitude)/2);
    [self.mapView setMapStatus:status withAnimation:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
