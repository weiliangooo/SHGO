//
//  BaseViewController.h
//  benben
//
//  Created by xunao on 15-2-27.
//  Copyright (c) 2015年 xunao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHHelpper.h"
#import "MBProgressHUD.h"
#import "XAClient.h"


@interface YHBaseViewController : UIViewController<MBProgressHUDDelegate,UITextFieldDelegate>

@property(nonatomic) UIImageView *noMoreInfo;

@property(nonatomic)int viewIndex;

@property(nonatomic)BOOL root;

@property(nonatomic)NSMutableArray *trumUnionArray;

@property(nonatomic)NSMutableArray *trumAreaArray;

@property (nonatomic) BOOL isLocationEnable;

@property(nonatomic)UIButton  *leftBtn;

@property(nonatomic)UIButton  *rightBtn;

@property(nonatomic)NSString *topTitle;

@property (nonatomic)NSString *navTitle;

@property(nonatomic)UIButton *locationBtn;

@property(nonatomic)UIImageView *img;

@property(nonatomic)UITextField *search;

@property(nonatomic)UIButton *rightBtn1;

/**
 1只有返回按钮
 2返回按钮和搜索按钮
 3首页top
 4搜索top
 5我的top
 6无按钮
 7 右边是收藏按钮
 8 右边是收藏按钮 点击
 **/
@property(nonatomic)int type;//

- (void)alertMessage:(NSString *)message;
//列表已加载全部
@property (nonatomic) UILabel *tableNoMoreView;

/**判断token是否过期方法**/
- (BOOL)isTimeoutWithToken;
- (void)backToLoginVC;
- (void)isLoginWith:(YHBaseViewController *)vc;

/**单例有loadingPOST*/
-(void)post:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

/**单例无loadingPOST*/
-(void)postback:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**多例POST*/
-(void)postInbackground:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

/**单例有loadingGET*/
-(void)get:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

/**单例无loadingGET*/
-(void)getNoLoading:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

/**多例无loadingGET*/
-(void)getback:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**PUT*/
-(void)put:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**DELECT*/
-(void)DELECT:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**上传带附件**/
-(void)POSTMultipartForm:(NSString *)api param:(NSMutableDictionary *)param files:(NSArray *)filesArray completion:(void (^)(id, NSError *))completion progress:(void (^)(float))progress;

/**nav-begin**/

-(void)ios7RightBarButtonItems:(UIBarButtonItem *)baritem;

-(void)ios7LeftBarButtonItems:(UIBarButtonItem *)baritem;


/**nav-end**/

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer;

///弹出系统提示框
-(void)alert:(NSString *)message;
//toast
-(void)toast:(NSString*)str;

-(void)showLoading:(NSString*)text;
-(void)hideLoading;

/**
 top左边按钮重写
 **/
-(void)leftBtn:(UIButton *)button;
/**
 top右边按钮重写
 **/
-(void)rightBtn:(UIButton *)button;
/**
电话
 **/
- (void)phoneAlertView:(NSString *)number;

- (void)phoneAlertView:(NSString *)number :(NSString *)title;
/**搜索**/
//-(BOOL)textFieldShouldReturn:(UITextField *)textField;

- (void)makeExtraCellLineHidden: (UITableView *)tableView;

-(void)backToLastVC;

-(void)gotoLoginViewController;

-(void)alReLoadData;

@end
