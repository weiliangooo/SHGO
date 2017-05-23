//
//  ChengKeMainViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//
#import "CKMainViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "CKLeftView.h"
#import "CKSearchPlaceView.h"
#import "CKTimeSelectView.h"
#import "CKPlaceTimeView.h"
#import "SignAlertView.h"
#import "CCMsgModel.h"
#import "CKCitysListModel.h"
#import "CKMsgListViewController.h"
#import "CKBookViewController.h"
#import "CKListViewController.h"
#import "CKWalletViewController.h"
#import "CKOrderViewController.h"
#import "CKSetUpViewController.h"
#import "CKMsgChangeViewController.h"
#import "UIImage+ScalImage.h"
#import "ADView.h"
#import "MyWebViewController.h"
#import "BaseNavViewController.h"
#import "CKShareViewController.h"

@interface CKMainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,CKSearchPlaceViewDelegate,BMKRouteSearchDelegate,CKPlaceTimeViewDelegate,CKLeftViewDelegate>
{
    ///用来记录当前所要搜索的城市 判断百度返回结果城市是否为要搜索的城市
    NSString *poiSearchCity;
    ///标示当前是否正在设置起始位置
    BOOL currentIsStart;
    ///存放后台传过来的地址数据
    CKCitysListModel *cityListModel;
}
///地图view
@property (nonatomic, strong)BMKMapView *mapView;
///展示乘客选择乘车起始位置 乘车时间的view
@property (nonatomic, strong)CKPlaceTimeView *ptView;
///起始位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *startAnnotation;
///终点位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *endAnnotation;
///左边的菜单界面
@property (nonatomic, strong)CKLeftView *leftView;
///搜索位置时，显示的view
@property (nonatomic, strong)CKSearchPlaceView *CKSPView;
///选择时间的view
@property (nonatomic, strong)CKTimeSelectView *ckTimeSelectView;
///搜索当前位置类，返回的是经纬度
@property (nonatomic, strong)BMKLocationService *locService;
//百度搜索服务类
@property (nonatomic, strong)BMKPoiSearch *poiSearch;

@end


@implementation CKMainViewController

-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    [self.navigationController.navigationBar setTranslucent:false];
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

///初始化数据
-(void)myInit{
    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate =self;
    
    _ccMsgModel = [[CCMsgModel alloc] init];
    
    currentIsStart = YES;
    
    _startAnnotation = [[BMKPointAnnotation alloc]init];
//    _startAnnotation.title = @"起点";
    
    _endAnnotation = [[BMKPointAnnotation alloc]init];
//    _endAnnotation.title = @"终点";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 2;
    [self.leftBtn setImage:[UIImage imageNamed:@"left_menu"] forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:@"right_msg"] forState:UIControlStateNormal];
//    self.topTitle = @"小马出行";
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
    titleView.contentMode = UIViewContentModeScaleAspectFill;
    titleView.frame = CGRectMake(0, 0, 75, 20);
    self.navigationItem.titleView = titleView;
    
    [self myInit];
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _mapView.zoomLevel = 17;
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomEnabledWithTap = NO;
    _mapView.overlookEnabled = NO;
    _mapView.rotateEnabled = NO;
    _mapView.delegate = self;
    self.view = _mapView;

    _CKSPView = [[CKSearchPlaceView alloc] initWithParentViewController:self];
    _CKSPView.delegate = self;
    
    _ptView = [[CKPlaceTimeView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 690*PROPORTION750, 300*PROPORTION750)];
    _ptView.delegate = self;
    [self.view addSubview:_ptView];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 680*PROPORTION750, 70*PROPORTION750, 70*PROPORTION750)];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn setImage:[[UIImage imageNamed:@"sy_share"] scaleImageByWidth:70*PROPORTION750] forState:UIControlStateNormal];
    shareBtn.tag = 500;
    [shareBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    UIButton *locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, shareBtn.bottom+30*PROPORTION750, 70*PROPORTION750, 70*PROPORTION750)];
//    locationBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    locationBtn.tag = 501;
    [locationBtn setImage:[[UIImage imageNamed:@"sy_location"] scaleImageByWidth:70*PROPORTION750] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
    
    [self requestForPlaces];
}

-(void)buttonClickEvents:(UIButton *)button{
    if (button.tag == 500) {
        CKShareViewController *viewController = [[CKShareViewController  alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        [self reloadCurrent];
    }
}

///reload data
-(void)reloadCurrent{
    currentIsStart = true;
    [_mapView removeAnnotation:_startAnnotation];
    [_mapView removeAnnotation:_endAnnotation];
    _ptView.startPlaceTF.text = @"";
    _ptView.endPlaceTF.text = @"";
//    _mapView.zoomLevel = 17;
    _ccMsgModel = [[CCMsgModel alloc] init];
    [_locService startUserLocationService];
}

#pragma --mark 重写父类的方法
-(void)leftBtn:(UIButton *)button{
    [self showLeftView];
}

-(void)rightBtn:(UIButton *)button{
    CKMsgListViewController *viewController = [[CKMsgListViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma --mark CKPlaceTimeView 代理函数
-(void)CKPlaceTimeViewClickEvents:(NSInteger)flag
{
    if(flag == 100){
        if (_ccMsgModel.startPlaceModel.cityName.length == 0){
            [self.CKSPView showViewWithPreFlag:CKSPViewStartStatusStartFalse startCityName:@""];
        }else{
            [self.CKSPView showViewWithPreFlag:CKSPViewStartStatusStartTrue startCityName:self.ccMsgModel.startPlaceModel.cityName];
        }
    }else if (flag == 200){
        [self.CKSPView showViewWithPreFlag:CKSPViewStartStatusEnd startCityName:@""];
    }else{
        if (_ccMsgModel.startPlaceModel.address.length == 0){
            [self toast:@"请填写出发地点"];
            return ;
        }
        if (_ccMsgModel.endPlaceModel.address.length == 0){
            [self toast:@"请填写目的地点"];
            return ;
        }
        
        NSString *startCityId = [self getCityIdWithCityName:_ccMsgModel.startPlaceModel];
        if (startCityId == nil){
            [self toast:@"出发城市选择暂不支持"];
            return;
        }
        
        NSString *endCityId = [self getCityIdWithCityName:_ccMsgModel.endPlaceModel];
        if (endCityId == nil){
            [self toast:@"目的城市选择暂不支持"];
            return;
        }
        
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       startCityId, @"start_address",
                                       endCityId, @"end_address",
                                       [MyHelperNO getUid], @"uid",
                                       [MyHelperNO getMyToken], @"token", nil];
        __weak typeof(self) weakSelf = self;
        [self post:@"index/timelist" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSString *msg = [responseObject stringForKey:@"msg"];
            NSLog(@"%@", responseObject);
            if (code == 200)
            {
                _ckTimeSelectView = [[CKTimeSelectView alloc] initWithData:[[responseObject objectForKey:@"data"] mutableCopy]];
                _ckTimeSelectView.CKTimeSelectBlock = ^(BOOL isCancle, NSString *timeStr, NSString *timeId){
                    if (!isCancle)
                    {
                        NSString *timeSp = [MyHelperTool normalTimeToTimeSP:timeStr];
//                        weakSelf.ccMsgModel.aboardTime = timeSp;
                        
                        NSString *startLocal = [MyHelperTool locationCoordinateToLocationString:weakSelf.ccMsgModel.startPlaceModel.location];
                        NSString *endLocal = [MyHelperTool locationCoordinateToLocationString:weakSelf.ccMsgModel.endPlaceModel.location];

                        NSMutableDictionary *reqDic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                       timeSp, @"choose_time",
                                                       timeId, @"banci_id",
                                                        startLocal,@"start_local",
                                                        endLocal,@"arr_local",
                                                       [MyHelperNO getUid], @"uid",
                                                       [MyHelperNO getMyToken], @"token",nil];
                        [weakSelf post:@"choosecar/placeorder" withParam:reqDic2 success:^(id responseObject) {
                            int code = [responseObject intForKey:@"status"];
                            NSString *msg = [responseObject stringForKey:@"msg"];
                            NSLog(@"%@", responseObject);
                            if (code == 200)
                            {
                                CKBookViewController *viewController = [[CKBookViewController alloc] initWithCCMsgModel:weakSelf.ccMsgModel];
                                viewController.inputData = [responseObject objectForKey:@"data"];
                                viewController.startLocal = startLocal;
                                viewController.endLocal = endLocal;
                                viewController.ccMsgModel = weakSelf.ccMsgModel;
                                [weakSelf.navigationController pushViewController:viewController animated:YES];
                            }
                            else if (code == 300)
                            {
                                [weakSelf toast:@"身份认证已过期"];
                                [weakSelf performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
                            }
                            else if (code == 400)
                            {
                                [weakSelf toast:msg];
                            }
                            
                        } failure:^(NSError *error) {
                            
                        }];
                    }
                };
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
}

#pragma --mark CKSearchPlaceView 代理函数
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView searchCity:(NSString *)searchCity keyWord:(NSString *)keyWord
{
    poiSearchCity = searchCity;
    //发起检索
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
    option.pageCapacity = 10;
    option.keyword = keyWord;
    option.city = poiSearchCity;
    option.requestPoiAddressInfoList = NO;
    BOOL flag = [self.poiSearch poiSearchInCity:option];
    if(flag){
        NSLog(@"周边检索发送成功");
    }else{
        NSLog(@"周边检索发送失败");
    }
}

-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView locationModel:(PlaceModel *)locationModel{
    [CKSPView hiddenView];
    if (CKSPView.preFlag == CKSPViewStartStatusStartTrue || CKSPView.preFlag == CKSPViewStartStatusStartFalse){
        currentIsStart = YES;
        self.ccMsgModel.startPlaceModel = locationModel;
        self.ptView.startPlaceTF.text = locationModel.address;
        [_mapView removeAnnotation: self.startAnnotation];
        self.startAnnotation.coordinate = locationModel.location;
        [_mapView addAnnotation:self.startAnnotation];
        self.ccMsgModel.endPlaceModel = nil;
        self.ptView.endPlaceTF.text = @"";
        [_mapView removeAnnotation:self.endAnnotation];
        [self onlyShowStartPlace];
    }else{
        currentIsStart = NO;
        self.ccMsgModel.endPlaceModel = locationModel;
        self.ptView.endPlaceTF.text = locationModel.address;
        self.endAnnotation.coordinate = locationModel.location;
        [_mapView addAnnotation:self.endAnnotation];
        [_mapView removeAnnotation: self.startAnnotation];
        self.startAnnotation.coordinate = _ccMsgModel.startPlaceModel.location;
        [_mapView addAnnotation:self.startAnnotation];
        [self getMapViewVisbleRect];
    }
}

///进入主界面时请求数据
-(void)requestForPlaces{
    NSMutableDictionary *reqDic= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [MyHelperNO getUid], @"uid",
                                  [MyHelperNO getMyToken], @"token", nil];
    [self post:@"index/index" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSString *msg = [responseObject stringForKey:@"msg"];
        NSLog(@"%@", responseObject);
        if (code == 200){
            if([[responseObject stringForKey:@"mes"] isEqualToString:@"1"]){
                [self.rightBtn setImage:[[UIImage imageNamed:@"right_msg_true"] scaleImageByWidth:35*PROPORTION750] forState:UIControlStateNormal];
            }else{
                [self.rightBtn setImage:[[UIImage imageNamed:@"right_msg"] scaleImageByWidth:35*PROPORTION750] forState:UIControlStateNormal];
            }
            NSArray *data = [NSArray arrayWithArray:[responseObject arrayForKey:@"data"]];
            cityListModel = [[CKCitysListModel alloc] initWithData:data];
            _CKSPView.defaultModel = cityListModel;
            
            _locService = [[BMKLocationService alloc]init];
            _locService.delegate = self;
            //启动LocationService
            [_locService startUserLocationService];
//            [self showLoading:@"正在加载..."];
            if (![[responseObject stringForKey:@"img"] isEqualToString:@"0"] && [MyHelperNO canPreAdView]) {
                [MyHelperNO savePreTime];
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
                
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    ADView *view = [[ADView alloc] init];
                    [view.imageView sd_setImageWithURL:[NSURL URLWithString:[responseObject stringForKey:@"img"]]];
                    view.imageTapBlock = ^(){
                        if(![[responseObject stringForKey:@"url"] isEqualToString:@"0"]){
                            MyWebViewController *viewController = [[MyWebViewController alloc] initWithTopTitle:@"活动介绍" urlString:[responseObject stringForKey:@"url"]];
                            BaseNavViewController *nv = [[BaseNavViewController alloc] initWithRootViewController:viewController];
                            [self presentViewController:nv animated:true completion:nil];
                        }
                    };

                });
            }
        }
        else if (code == 300){
            [self toast:@"身份认证已过期"];
            [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
        }
        else if (code == 400){
            [self toast:msg];
        }
    } failure:^(NSError *error) {
        
    }];
}


///设置起始位置 和 终点位置 的大头钉的图片
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]){
        if (annotation == _startAnnotation){
            BMKAnnotationView *newStart = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"startAnnotation"];
            if (currentIsStart) {
                newStart.image = [UIImage imageNamed:@"startPoint1"];   //把大头针换成别的图片
                newStart.centerOffset = CGPointMake(0, -newStart.image.size.height/2);
            }else{
                newStart.image = [UIImage imageNamed:@"starPoint"];   //把大头针换成别的图片
                newStart.centerOffset = CGPointMake(0, -newStart.image.size.height/2);
            }
            return newStart;
        }else{
            BMKAnnotationView *newEnd = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"endAnnotation"];
            newEnd.image = [UIImage imageNamed:@"endPoint"];   //把大头针换成别的图片
            newEnd.centerOffset = CGPointMake(0, -newEnd.image.size.height/2);
            return newEnd;
        }
    }
    return nil;
}

//实现相关delegate 处理位置信息更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //获取当前城市
    BMKCoordinateRegion region;
    
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                NSString *city=placemark.locality;
                if (city.length != 0){
                    [self onlyShowStartPlace];
                    [_locService stopUserLocationService];
                    [self hideLoading];
                }
            }
        }
    }];
    //设置地图的中心
    [_mapView setCenterCoordinate:userLocation.location.coordinate];
    [_mapView addAnnotation:_startAnnotation];
}


//地图拖动后 获取当前地图中心位置的地理信息
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"had changed, %f, %f", mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude);
    
    //初始化地理编码类
    BMKGeoCodeSearch *_geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    _geoCodeSearch.delegate = self;
    //初始化逆地理编码类
    BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    //需要逆地理编码的坐标位置
    reverseGeoCodeOption.reverseGeoPoint = mapView.centerCoordinate;
    if (currentIsStart){
        self.ccMsgModel.startPlaceModel.location = mapView.centerCoordinate;
        _startAnnotation.coordinate = mapView.centerCoordinate;
    }
    [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
    if(currentIsStart){
        BMKPoiInfo *info = [[BMKPoiInfo alloc] init];
        info = result.poiList[0];
        
        NSString *city;
        if ([self isSupportCity:result.addressDetail.district]){
            city = result.addressDetail.district;
            PlaceModel *model = [[PlaceModel alloc] init];
            model.cityName = city;
            model.address = info.name;
            model.detailAddress = info.address;
            model.location = result.location;
            self.ccMsgModel.startPlaceModel = model;
            _ptView.startPlaceTF.text = model.address;
        }
        else if ([self isSupportCity:result.addressDetail.city]){
            city = result.addressDetail.city;
            PlaceModel *model = [[PlaceModel alloc] init];
            model.cityName = city;
            model.address = info.name;
            model.detailAddress = info.address;
            model.location = result.location;
            self.ccMsgModel.startPlaceModel = model;
            _ptView.startPlaceTF.text = model.address;
        }
//        else if ([self isSupportCity:result.addressDetail.district]){
//            city = result.addressDetail.district;
//            PlaceModel *model = [[PlaceModel alloc] init];
//            model.cityName = city;
//            model.address = info.name;
//            model.detailAddress = info.address;
//            model.location = result.location;
//            self.ccMsgModel.startPlaceModel = model;
//            _ptView.startPlaceTF.text = model.address;
//        }
        else{
            self.ccMsgModel.startPlaceModel = nil;
            _ptView.startPlaceTF.text = @"";
//            [self toast:@"当前城市不支持"];
//            _mapView
        }
    }
}

//城市检索回调
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR)
    {
        NSMutableArray *addressArray = [NSMutableArray array];
        [addressArray removeAllObjects];
        for (BMKPoiInfo *objc in poiResult.poiInfoList)
        {
            if ([poiSearchCity isEqualToString:objc.city])
            {
                [addressArray addObject:objc];
            }
        }
        [_CKSPView setDataArray:addressArray];
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        if (currentIsStart)
        {
            self.ccMsgModel.startPlaceModel.location = result.location;
            _startAnnotation.coordinate = result.location;
            //在此处理正常结果
            [_mapView setCenterCoordinate:result.location];
        }
        else
        {
            self.ccMsgModel.endPlaceModel.location = result.location;
            _endAnnotation.coordinate = result.location;
            [_mapView addAnnotation:_endAnnotation];
            [self getMapViewVisbleRect];
        }
    }
    else
    {
        NSLog(@"抱歉，未找到结果");
    }
}


//计算地图显示区域
-(void)getMapViewVisbleRect
{
    BMKMapPoint point1 = BMKMapPointForCoordinate(self.ccMsgModel.startPlaceModel.location);
    BMKMapPoint point2 = BMKMapPointForCoordinate(self.ccMsgModel.endPlaceModel.location);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);

    //这个数组就是百度地图比例尺对应的物理距离，其中2000000对应的比例是3，5对应的是21；可能有出入可以根据情况累加
    float zoomLe = 0.00;
    NSArray *zoomLevelArr = [[NSArray alloc]initWithObjects:@"2000000", @"1000000", @"500000", @"200000", @"100000", @"50000", @"25000", @"20000", @"10000", @"5000", @"2000", @"1000", @"500", @"200", @"100", @"50", @"20", @"10", @"5", nil];
    for (int j=0; j < zoomLevelArr.count; j++)
    {
        if (j + 1 < zoomLevelArr.count)
        {
            if (distance < [zoomLevelArr[j] intValue] && distance > [zoomLevelArr[j+1] intValue] )
            {
                zoomLe = j+7;
                break;
            }
        }    
    }
    
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = zoomLe;
    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, 750*PROPORTION750);
    status.targetGeoPt = CLLocationCoordinate2DMake(
                                                    (self.ccMsgModel.startPlaceModel.location.latitude+self.ccMsgModel.endPlaceModel.location.latitude)/2,
                                                    (self.ccMsgModel.startPlaceModel.location.longitude+self.ccMsgModel.endPlaceModel.location.longitude)/2);
    [_mapView setMapStatus:status withAnimation:YES];
    
}

//用来弹出左边菜单栏
-(void)showLeftView
{
    if (!_leftView) {
        _leftView = [[CKLeftView alloc] initWithViewController:self];
        _leftView.delegate = self;
    }else{
        [_leftView showView];
    }
}

#pragma --mark CKLeftViewDelegate
-(void)CKLeftView:(CKLeftView *)leftView didSelectFlag:(NSInteger)flag{
    [leftView hiddenViewAtonce];
    switch (flag) {
        case 100:
        {
            CKWalletViewController *viewController = [[CKWalletViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 101:
        {
            CKOrderViewController *viewController = [[CKOrderViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 102:
        {
            CKListViewController *viewController = [[CKListViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 103:
        {
            CKSetUpViewController *viewController = [[CKSetUpViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 201:
        {
            CKMsgChangeViewController *viewController = [[CKMsgChangeViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 202:
        {
            NSMutableDictionary *reqDic= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [MyHelperNO getUid], @"uid",
                                          [MyHelperNO getMyToken], @"token", nil];
            [self post:@"user/sign" withParam:reqDic success:^(id responseObject) {
                int code = [responseObject intForKey:@"status"];
                NSString *msg = [responseObject stringForKey:@"msg"];
                NSLog(@"%@", responseObject);
                if (code == 200)
                {
                    [_leftView.myTableHead setUpSignBtnStauts:true];
                    SignAlertView *alerView = [[SignAlertView alloc] initWithTipTitle:[NSString stringWithFormat:@"获得红包%@元", [responseObject stringForKey:@"data"]]];
                }
                else if (code == 300)
                {
                    [self toast:@"身份认证已过期"];
                    [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
                }
                else if (code == 400)
                {
                    [_leftView.myTableHead setUpSignBtnStauts:true];
                    [self toast:msg];
                }
            } failure:^(NSError *error) {
                
            }];
        }
            break;
        default:
            break;
    }

}


///通过城市的名称 获取城市在服务器对应的id
-(NSString *)getCityIdWithCityName:(PlaceModel *)placeModel{
    for (int i = 0; i < cityListModel.citysModel.count; i++){
        CKCitysModel *model = [[CKCitysModel alloc] init];
        model = [cityListModel.citysModel objectAtIndex:i];
        
        if ([placeModel.detailAddress rangeOfString:model.cityName].location == NSNotFound && [placeModel.cityName rangeOfString:model.cityName].location == NSNotFound) {
            NSLog(@"string 不存在 martin");
        } else {
            NSLog(@"string 包含 martin");
            return model.cityId;
        }
    }
    return nil;
}

///只显示起始地点地图配置
-(void)onlyShowStartPlace{
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = 17;
    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, _ptView.bottom+210*PROPORTION750);
    status.targetGeoPt = _startAnnotation.coordinate;
    [_mapView setMapStatus:status withAnimation:YES];
    
}

///判断当前定位城市是否支持
-(BOOL)isSupportCity:(NSString *)city{
    if (city == nil){
        return NO;
    }
    for (CKCitysModel *model in cityListModel.citysModel){
        if ([model.cityName hasPrefix:city]){
            return YES;
        }
    }
    return NO;
}


-(void)alReLoadData{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
