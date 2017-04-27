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
    ///当前列表的数据类型
    DataSourceTypeCity = 0,      ///服务器城市数据
    DataSourceTypeHot = 1,       ///服务器热门地点数据
    DataSourceTypeBaidu = 2,     ///百度搜索返回的地点数据
} DataSourceType;

@class PlaceModel;
@class CKCitysListModel;
@class CKSearchPlaceView;
@protocol CKSearchPlaceViewDelegate <NSObject>

@required
///点击取消按钮 后隐藏地址搜索界面
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView cancleBtnClick:(UIButton *)cancleBtn;
///关键词搜索
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView searchCity:(NSString *)searchCity keyWord:(NSString *)keyWord;
///传出选中的地址信息
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView locationModel:(PlaceModel *)locationModel;
//toast
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView toast:(NSString *)toast;

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
///标示当前界面展示时的状态 1:选择出发地点 出发城市可用 2:选择出发地点 出发城市不可用 3:选择目的地点
@property (nonatomic, assign) NSInteger preFlag;

@end

