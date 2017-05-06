//
//  CKMapViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMapViewController.h"


@implementation CKMapViewController

-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    self.navigationController.navigationBar.translucent = false;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

-(instancetype)initWithCCMsgModel:(CCMsgModel *)ccMsgModel{
    if (self = [super init]){
        _ccMsgModel = ccMsgModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"确认预定";
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _mapView.zoomLevel = 17;
    _mapView.gesturesEnabled = NO;
    _mapView.delegate = self;
    self.view = _mapView;
    
    _startAnnotation = [[BMKPointAnnotation alloc]init];
    _startAnnotation.title = @"起点";
    _startAnnotation.subtitle = _ccMsgModel.startPlaceModel.address;
    _startAnnotation.coordinate = _ccMsgModel.startPlaceModel.location;
    [_mapView addAnnotation:_startAnnotation];

    _endAnnotation = [[BMKPointAnnotation alloc]init];
    _endAnnotation.title = @"终点";
    _endAnnotation.subtitle = _ccMsgModel.endPlaceModel.address;
    _endAnnotation.coordinate = _ccMsgModel.endPlaceModel.location;
    [_mapView addAnnotation:_endAnnotation];
    
    [self getMapViewVisbleRect];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]){
        if (annotation == _startAnnotation){
            BMKAnnotationView *newStart = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"startAnnotation"];
            newStart.image = [UIImage imageNamed:@"startPoint"];   //把大头针换成别的图片
            return newStart;
        }else{
            BMKAnnotationView *newStart = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"endAnnotation"];
            newStart.image = [UIImage imageNamed:@"endPoint"];   //把大头针换成别的图片
            return newStart;
        }
    }
    return nil;
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
    for (int j=0; j<zoomLevelArr.count; j++){
        if (j + 1 < zoomLevelArr.count){
            if (distance < [zoomLevelArr[j] intValue] && distance > [zoomLevelArr[j+1] intValue] ){
                zoomLe = j+7;
                break;
            }
        }
    }
    
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = zoomLe;
    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, 450*PROPORTION750);
    status.targetGeoPt = CLLocationCoordinate2DMake((self.ccMsgModel.startPlaceModel.location.latitude+self.ccMsgModel.endPlaceModel.location.latitude)/2,
                                                    (self.ccMsgModel.startPlaceModel.location.longitude+self.ccMsgModel.endPlaceModel.location.longitude)/2);
    [_mapView setMapStatus:status withAnimation:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
