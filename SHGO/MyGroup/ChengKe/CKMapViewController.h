//
//  CKMapViewController.h
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "CCMsgModel.h"

@interface CKMapViewController : YHBaseViewController<BMKMapViewDelegate>
///地图view
@property (nonatomic, strong)BMKMapView *mapView;
///起始位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *startAnnotation;
///终点位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *endAnnotation;
///用来盛放用户乘车信息的model
@property (nonatomic, strong)CCMsgModel *ccMsgModel;

-(instancetype)initWithCCMsgModel:(CCMsgModel *)ccMsgModel;

@end

@interface myAnnotationView : BMKAnnotationView

@end
