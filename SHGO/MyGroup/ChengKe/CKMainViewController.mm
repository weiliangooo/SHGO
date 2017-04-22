//
//  ChengKeMainViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMainViewController.h"
#import "AppDelegate.h"
#import "CKLeftView.h"
#import "CKCenterView.h"
#import "CKSearchPlaceView.h"
#import "CKTimeSelectView.h"
#import "CKBookViewController.h"
#import "CKListViewController.h"
#import "CKWalletViewController.h"
#import "CKOrderViewController.h"
#import "CKSetUpViewController.h"
#import "CKMsgChangeViewController.h"
#import "SignAlertView.h"

@interface CKMainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,CKSearchPlaceViewDelegate,BMKRouteSearchDelegate,CKPlaceTimeViewDelegate>

///左边的菜单界面
@property (nonatomic, strong)CKLeftView *leftView;
///展示左边菜单栏时 显示的遮罩view
@property (nonatomic, strong)UIView *maskView;
///地图view
@property (nonatomic, strong)BMKMapView *mapView;
///搜索当前位置类，返回的是经纬度
@property (nonatomic, strong)BMKLocationService *locService;
///搜索位置时，显示的view
@property (nonatomic, strong)CKSearchPlaceView *CKSPView;
///搜索当前位置类，返回的是地点名称
@property (nonatomic, strong)BMKPoiSearch *poiSearch;
///选择时间的view
@property (nonatomic, strong)CKTimeSelectView *ckTimeSelectView;

@end

@implementation CKMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    [self.navigationController.navigationBar setTranslucent:false];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}


-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

//懒加载baidu poi搜索
-(BMKPoiSearch *)poiSearch
{
    if (!_poiSearch)
    {
        _poiSearch = [[BMKPoiSearch alloc] init];
        _poiSearch.delegate =self;
    }
    return _poiSearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 2;
    [self.leftBtn setImage:[UIImage imageNamed:@"left_menu"] forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:@"right_msg"] forState:UIControlStateNormal];
    self.topTitle = @"小马出行";
    
    _ccMsgModel = [[CCMsgModel alloc] init];
    _currentIsStart = YES;
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _mapView.zoomLevel = 17;
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomEnabledWithTap = NO;
    _mapView.overlookEnabled = NO;
    _mapView.rotateEnabled = NO;
//    _mapView.trafficEnabled = YES;
    _mapView.delegate = self;
    self.view = _mapView;
    
    _startAnnotation = [[BMKPointAnnotation alloc]init];
    _startAnnotation.title = @"起点";
    
    _endAnnotation = [[BMKPointAnnotation alloc]init];
    _endAnnotation.title = @"终点";
    

    _CKSPView = [[CKSearchPlaceView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _CKSPView.delegate = self;
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [de.window addSubview:_CKSPView];

    _ptView = [[CKPlaceTimeView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 690*PROPORTION750, 300*PROPORTION750)];
    _ptView.delegate = self;
    [self.view addSubview:_ptView];

    [self requestForPlaces];
}

-(void)leftBtn:(UIButton *)button
{
    [self showLeftView];
}

-(void)rightBtn:(UIButton *)button
{
    
}

#pragma --mark CKPlaceTimeView 代理函数
-(void)CKPlaceTimeViewClickEvents:(NSInteger)flag
{
    if(flag == 100)
    {
        _currentIsStart = YES;
        self.CKSPView.cityTF.placeholder = @"出发城市";
        if (_ccMsgModel.startPlaceModel.cityName.length == 0)
        {
            self.CKSPView.cityTF.text = @"";
            self.CKSPView.preFlag = 2;
        }
        else
        {
            self.CKSPView.cityTF.text = self.ccMsgModel.startPlaceModel.cityName;
            self.CKSPView.preFlag = 1;
        }
        self.CKSPView.placeTF.text = @"";
        self.CKSPView.placeTF.placeholder = @"您现在在哪儿";
        [self.CKSPView.dataArray removeAllObjects];
        [UIView animateWithDuration:0.5f animations:^{
            self.CKSPView.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
            [self.navigationController setNavigationBarHidden:YES];
        } completion:^(BOOL finished) {
            if (self.ccMsgModel.startPlaceModel.cityName.length == 0)
            {
                [self.CKSPView.cityTF becomeFirstResponder];
            }
            else
            {
                [self.CKSPView.placeTF becomeFirstResponder];
            }
            
        }];
    }
    else if (flag == 200)
    {
        _currentIsStart = NO;
        self.CKSPView.cityTF.placeholder = @"到达城市";
        self.CKSPView.cityTF.text = @"";
        self.CKSPView.placeTF.text = @"";
        self.CKSPView.preFlag = 3;
        [self.CKSPView.dataArray removeAllObjects];
        [UIView animateWithDuration:0.5f animations:^{
            self.CKSPView.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
            [self.navigationController setNavigationBarHidden:YES];
        } completion:^(BOOL finished) {
            [self.CKSPView.cityTF becomeFirstResponder];
        }];
    }
    else
    {
        if (_ccMsgModel.startPlaceModel.address.length == 0)
        {
            [self toast:@"请填写出发地点"];
            return ;
        }
        if (_ccMsgModel.endPlaceModel.address.length == 0)
        {
            [self toast:@"请填写目的地点"];
            return ;
        }
        
        NSString *startCityId = [self getCityIdWithCityName:_ccMsgModel.startPlaceModel.cityName];
        if (startCityId == nil)
        {
            [self toast:@"出发城市选择暂不支持"];
            return;
        }
        
        NSString *endCityId = [self getCityIdWithCityName:_ccMsgModel.endPlaceModel.cityName];
        if (endCityId == nil)
        {
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
                _ckTimeSelectView = [[CKTimeSelectView alloc] initWithData:[responseObject objectForKey:@"data"]];
                _ckTimeSelectView.CKTimeSelectBlock = ^(BOOL isCancle, NSString *timeStr, NSString *timeId){
                    if (!isCancle)
                    {
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                        NSDate* date = [formatter dateFromString:timeStr];
                        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
                        weakSelf.ccMsgModel.aboardTime = timeSp;
                        
                        NSString *startLocal = [weakSelf.ccMsgModel.startPlaceModel locationToString];
                        NSString *endLocal = [weakSelf.ccMsgModel.endPlaceModel locationToString];
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
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView cancleBtnClick:(UIButton *)cancleBtn
{
    [UIView animateWithDuration:0.5f animations:^{
        CKSPView.frame = CGRectMake(0, AL_DEVICE_HEIGHT, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        [self.navigationController setNavigationBarHidden:NO];
    }];
}

-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView searchCity:(NSString *)searchCity keyWord:(NSString *)keyWord
{
    //发起检索
    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
    option.pageCapacity = 10;
    option.keyword = keyWord;
    option.city = searchCity;
    option.requestPoiAddressInfoList = YES;
    BOOL flag = [self.poiSearch poiSearchInCity:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
}

-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView locationModel:(PlaceModel *)locationModel
{
    [UIView animateWithDuration:0.5f animations:^{
        CKSPView.frame = CGRectMake(0, AL_DEVICE_HEIGHT, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        [self.navigationController setNavigationBarHidden:NO];
    }];
    
    if (CKSPView.preFlag == 1 || CKSPView.preFlag == 2)
    {
        self.ccMsgModel.startPlaceModel = locationModel;
        self.ptView.startPlaceTF.text = locationModel.address;
        self.startAnnotation.coordinate = locationModel.location;
        
        self.ccMsgModel.endPlaceModel = nil;
        self.ptView.endPlaceTF.text = @"";
        [_mapView removeAnnotation:self.endAnnotation];
        
        [self onlyShowStartPlace];
    }
    else
    {
        self.ccMsgModel.endPlaceModel = locationModel;
        self.ptView.endPlaceTF.text = locationModel.address;
        self.endAnnotation.coordinate = locationModel.location;
        [_mapView addAnnotation:self.endAnnotation];
        
        [self getMapViewVisbleRect];
    }
    
    
}

-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView toast:(NSString *)toast
{
    [self alert:toast];
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
            [addressArray addObject:objc];
        }
        [_CKSPView setDataArray:addressArray];
    }
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
//                NSData *data = [NSJSONSerialization dataWithJSONObject:placemark.addressDictionary options:NSJSONWritingPrettyPrinted error:nil];
//                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@", jsonString);
                if (city.length != 0)
                {
                    if ([self isSupportCity:placemark.locality])
                    {
                        city = placemark.locality;
                        PlaceModel *model = [[PlaceModel alloc] init];
                        model.cityName = city;
                        model.address = placemark.name;
                        model.detailAddress = placemark.thoroughfare;
                        model.location = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
                        self.ccMsgModel.startPlaceModel = model;
                        _ptView.startPlaceTF.text = model.address;
                    }
                    else if ([self isSupportCity:placemark.subLocality])
                    {
                        city = placemark.subLocality;
                        PlaceModel *model = [[PlaceModel alloc] init];
                        model.cityName = city;
                        model.address = placemark.name;
                        model.detailAddress = placemark.thoroughfare;
                        model.location = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
                        self.ccMsgModel.startPlaceModel = model;
                        _ptView.startPlaceTF.text = model.address;
                    }
                    else
                    {
                        [self toast:@"当前城市不支持!"];
                        _ptView.startPlaceTF.text = @"";
                    }
                    
                    [_locService stopUserLocationService];
                    
                    [self hideLoading];
//                    [self requestForPlaces];
                }
                
//                //初始化地理编码类
//                BMKGeoCodeSearch *_geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
//                _geoCodeSearch.delegate = self;
//                //初始化逆地理编码类
//                BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
//                //需要逆地理编码的坐标位置
//                reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
//                [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
                
                
            }
        }
    }];
    //设置地图的中心
    [_mapView setCenterCoordinate:userLocation.location.coordinate];
    _startAnnotation.coordinate = userLocation.location.coordinate;
    [_mapView addAnnotation:_startAnnotation];
}

-(void)requestForPlaces
{
    
    NSMutableDictionary *reqDic= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [MyHelperNO getUid], @"uid",
                                  [MyHelperNO getMyToken], @"token", nil];
    [self post:@"index/index" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSString *msg = [responseObject stringForKey:@"msg"];
        NSLog(@"%@", responseObject);
        if (code == 200)
        {
            NSArray *data = [NSArray arrayWithArray:[responseObject arrayForKey:@"data"]];
            _cityListModel = [[CKCitysListModel alloc] initWithData:data];
            _CKSPView.defaultModel = _cityListModel;
            
            _locService = [[BMKLocationService alloc]init];
            _locService.delegate = self;
            //启动LocationService
            [_locService startUserLocationService];
            [self showLoading:@"正在加载..."];
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


///设置起始位置 和 终点位置 的大头钉的图片
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        if (annotation == _startAnnotation)
        {
            BMKAnnotationView *newStart = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"startAnnotation"];
            newStart.image = [UIImage imageNamed:@"startPoint"];   //把大头针换成别的图片
            return newStart;
        }
        else
        {
            BMKAnnotationView *newEnd = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"endAnnotation"];
            newEnd.image = [UIImage imageNamed:@"endPoint"];   //把大头针换成别的图片
            return newEnd;
        }
    }
    
    return nil;
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
    if (_currentIsStart)
    {
        self.ccMsgModel.startPlaceModel.location = mapView.centerCoordinate;
        _startAnnotation.coordinate = mapView.centerCoordinate;
//        if (self.ccMsgModel.endDetailAddress.length > 0 || self.ccMsgModel.endDetailAddress != nil)
//        {
//            [self getMapViewVisbleRect];
//        }
    }
    [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    
}

//    BMKGeoCodeSearch *_searcher =[[BMKGeoCodeSearch alloc]init];
//    _searcher.delegate = self;
//    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
//    geoCodeSearchOption.city= locationModel.city;
//    geoCodeSearchOption.address = locationModel.detailAddress;
//    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"geo检索发送失败");
//    }

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        if (_currentIsStart)
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

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
    if(_currentIsStart)
    {
        BMKPoiInfo *info = [[BMKPoiInfo alloc] init];
        info = result.poiList[0];
   
        NSString *city;
        if ([self isSupportCity:result.addressDetail.city])
        {
            city = result.addressDetail.city;
            PlaceModel *model = [[PlaceModel alloc] init];
            model.cityName = city;
            model.address = info.name;
            model.detailAddress = info.address;
            model.location = result.location;
            self.ccMsgModel.startPlaceModel = model;
            _ptView.startPlaceTF.text = model.address;
        }
        else if ([self isSupportCity:result.addressDetail.district])
        {
            city = result.addressDetail.city;
            PlaceModel *model = [[PlaceModel alloc] init];
            model.cityName = city;
            model.address = info.name;
            model.detailAddress = info.address;
            model.location = result.location;
            self.ccMsgModel.startPlaceModel = model;
            _ptView.startPlaceTF.text = model.address;
        }
        else
        {
            self.ccMsgModel.startPlaceModel = nil;
            _ptView.startPlaceTF.text = @"";
        }
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
//                [_mapView setZoomLevel:j+6];
                zoomLe = j+7;
                break;
            }
        }    
    }
    
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = zoomLe;
    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, 750*PROPORTION750);
    status.targetGeoPt = CLLocationCoordinate2DMake((self.ccMsgModel.startPlaceModel.location.latitude+self.ccMsgModel.endPlaceModel.location.latitude)/2,
                                                    (self.ccMsgModel.startPlaceModel.location.longitude+self.ccMsgModel.endPlaceModel.location.longitude)/2);
    [_mapView setMapStatus:status withAnimation:YES];
    
}

//用来弹出左边菜单栏
-(void)showLeftView
{
    if (!_maskView)
    {
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        _maskView.userInteractionEnabled = YES;
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissLeftView)]];
        [de.window addSubview:_maskView];
        
        _leftView = [[CKLeftView alloc] initWithFrame:CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height) withViewController:self];
        _leftView.didSelectedBlock = ^(NSInteger row){
            switch (row) {
                case 0:
                {
                    _leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
                    _maskView.hidden = YES;
                    CKWalletViewController *viewController = [[CKWalletViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                case 1:
                {
                    _leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
                    _maskView.hidden = YES;
                    CKOrderViewController *viewController = [[CKOrderViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                case 2:
                {
                    _leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
                    _maskView.hidden = YES;
                    CKListViewController *viewController = [[CKListViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                case 3:
                {
                    _leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
                    _maskView.hidden = YES;
                    CKSetUpViewController *viewController = [[CKSetUpViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                case 100:
                {
                    _leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
                    _maskView.hidden = YES;
                    CKMsgChangeViewController *viewController = [[CKMsgChangeViewController alloc] init];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                case 200:
                {
                    
                    _leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
                    _maskView.hidden = YES;
                    SignAlertView *alerView = [[SignAlertView alloc] initWithTipTitle:@"获得红包5.00元"];
                }
                    break;
                    
                default:
                    break;
            }
        };
        _leftView.backgroundColor = [UIColor whiteColor];
        [de.window addSubview:_leftView];
        
        [UIView animateWithDuration:0.5f animations:^{
            _leftView.frame = CGRectMake(0, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
        } completion:nil];
        
    }
    else
    {
        _maskView.hidden = NO;
        [UIView animateWithDuration:0.5f animations:^{
            _leftView.frame = CGRectMake(0, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
        } completion:nil];
    }
}



//隐藏左边菜单栏
-(void)dismissLeftView
{
    [UIView animateWithDuration:0.5f animations:^{
        _leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        _maskView.hidden = YES;
    }];
}


///通过城市的名称 获取城市在服务器对应的id
-(NSString *)getCityIdWithCityName:(NSString *)cityName
{
    for (int i = 0; i < _cityListModel.citysModel.count; i++)
    {
        CKCitysModel *model = [[CKCitysModel alloc] init];
        model = [_cityListModel.citysModel objectAtIndex:i];
        if ([model.cityName hasPrefix:cityName])
        {
            return model.cityId;
        }
    }
    return nil;
}

///只显示起始地点地图配置
-(void)onlyShowStartPlace
{
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = 17;
    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, _ptView.bottom+210*PROPORTION750);
    status.targetGeoPt = _startAnnotation.coordinate;
    [_mapView setMapStatus:status withAnimation:YES];
    
}

///判断当前定位城市是否支持
-(BOOL)isSupportCity:(NSString *)city
{
    if (city == nil)
    {
        return NO;
    }
    for (CKCitysModel *model in _cityListModel.citysModel)
    {
        if ([model.cityName hasPrefix:city])
        {
            return YES;
        }
    }
    return NO;
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
