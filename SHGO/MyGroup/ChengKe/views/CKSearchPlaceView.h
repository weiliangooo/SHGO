//
//  CKSearchPlaceView.h
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import "CKCitysListModel.h"

@class CKSearchPlaceView;
@class myLocationModel;

@protocol CKSearchPlaceViewDelegate <NSObject>

@required
///点击取消按钮 后隐藏地址搜索界面
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView cancleBtnClick:(UIButton *)cancleBtn;
///关键词搜索
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView searchCity:(NSString *)searchCity keyWord:(NSString *)keyWord;
///传出选中的地址信息
-(void)CKSearchPlaceView:(CKSearchPlaceView *)CKSPView locationModel:(myLocationModel *)locationModel;
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
///返回的数据
@property (nonatomic, strong) myLocationModel *locationModel;
///tableview的数据容器
@property (nonatomic, strong) NSMutableArray *dataArray;
///从服务器获取的城市和热门地点的数据
@property (nonatomic, strong) CKCitysListModel *defaultModel;
///表示tablevew的数据源 0:服务器城市 1:服务器热门地点 2:百度搜索地点
@property (nonatomic, assign) NSInteger typeOfData;

@end


@interface myLocationModel : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *detailAddress;
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, assign) CLLocationCoordinate2D location;

@end
