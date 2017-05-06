//
//  CKSearchPlaceView.h
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>

typedef enum : NSUInteger {
    ///进入当前界面的状态
    CKSPViewStartStatusStartTrue = 1,   ///选择出发地点 出发城市可用
    CKSPViewStartStatusStartFalse = 2,  ///选择出发地点 出发城市不可用
    CKSPViewStartStatusEnd = 3,         ///选择目的地点
} CKSPViewStartStatus;

typedef enum : NSUInteger {
    ///当前列表的数据类型
    DataSourceTypeCity = 0,      ///服务器城市数据
    DataSourceTypeHot = 1,       ///服务器热门地点数据
    DataSourceTypeBaidu = 2,     ///百度搜索返回的地点数据
} DataSourceType;

@class YHBaseViewController;
@class PlaceModel;
@class CKCitysListModel;
@class CKSearchPlaceView;
@protocol CKSearchPlaceViewDelegate <NSObject>

@required
///关键词搜索
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView searchCity:(NSString *)searchCity keyWord:(NSString *)keyWord;
///传出选中的地址信息
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView locationModel:(PlaceModel *)locationModel;

@end


@interface CKSearchPlaceView : UIView <UITextFieldDelegate>

@property (nonatomic, assign)id<CKSearchPlaceViewDelegate> delegate;
///城市输入框
@property (nonatomic, strong)UITextField *cityTF;
///地点输入框
@property (nonatomic, strong)UITextField *placeTF;
///tableview 展示列表
@property (nonatomic, strong)UITableView *placeTableView;
///tableview的数据容器
@property (nonatomic, strong) NSMutableArray *dataArray;
///从服务器获取的城市和热门地点的数据
@property (nonatomic, strong) CKCitysListModel *defaultModel;
@property (nonatomic, assign) DataSourceType typeOfData;
@property (nonatomic, assign) CKSPViewStartStatus preFlag;

///初始化
-(instancetype)initWithParentViewController:(YHBaseViewController *)viewController;
///展示界面
-(void)showViewWithPreFlag:(CKSPViewStartStatus)flag startCityName:(NSString *)cityName;
///隐藏界面
-(void)hiddenView;

@end

