//
//  ChengKeMainViewController.h
//  SHGO
//
//  Created by Alen on 2017/3/22.
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
#import "ChengKePlaceTimeView.h"

#import "CCMsgModel.h"

#import "CKCitysListModel.h"


@interface ChengKeMainViewController : YHBaseViewController <BMKPoiSearchDelegate>
///展示乘客选择乘车起始位置 乘车时间的view
@property (nonatomic, strong)ChengKePlaceTimeView *ptView;
///用来盛放用户乘车信息的model
@property (nonatomic, strong)CCMsgModel *ccMsgModel;
///标示当前是否正在设置起始位置
@property (nonatomic, assign)BOOL currentIsStart;
///起始位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *startAnnotation;
///终点位置的大头钉
@property (nonatomic, strong)BMKPointAnnotation *endAnnotation;

@property (nonatomic, strong)CKCitysListModel *cityListModel;

@end
