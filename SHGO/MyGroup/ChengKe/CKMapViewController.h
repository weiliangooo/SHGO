//
//  CKMapViewController.h
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Search/BMKRouteSearchOption.h>
#import <BaiduMapAPI_Search/BMKRouteSearchType.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPolyline.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>

#import "CCMsgModel.h"

@interface CKMapViewController : YHBaseViewController<BMKMapViewDelegate>

///用来盛放用户乘车信息的model
@property (nonatomic, strong)CCMsgModel *ccMsgModel;
///地图view
@property (nonatomic, strong)BMKMapView *mapView;
///起始位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *startAnnotation;
///终点位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *endAnnotation;

-(instancetype)initWithCCMsgModel:(CCMsgModel *)ccMsgModel;

@end


@interface myAnnotationView : BMKAnnotationView

@end
