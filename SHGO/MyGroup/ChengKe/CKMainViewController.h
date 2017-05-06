//
//  ChengKeMainViewController.h
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "CKPlaceTimeView.h"

#import "CCMsgModel.h"

#import "CKCitysListModel.h"


@interface CKMainViewController : YHBaseViewController <BMKPoiSearchDelegate>
///展示乘客选择乘车起始位置 乘车时间的view
@property (nonatomic, strong)CKPlaceTimeView *ptView;
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
