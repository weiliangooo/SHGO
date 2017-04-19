//
//  CKBookView.h
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCMsgModel.h"
#import "ActivityModel.h"


@class CKBookView;
@class CKBookMsgView;

@protocol CKBookViewDelegate <NSObject>
///点击立即预订  返回乘客成员信息
-(void)CKBookViewClickSureBtn;

@end

@interface CKBookView : UIView

@property (nonatomic, assign) id<CKBookViewDelegate> delegate;

@property (nonatomic, strong) CKBookMsgView *ckBookMsgView;

@property (nonatomic, strong) NSDictionary * inputData;

-(instancetype)initWithFrame:(CGRect)frame inputData:(NSDictionary *)inputData;

@end


@protocol CKBookMsgViewDelegate <NSObject>
///flag=1:选择乘客界面  flag=2:选择优惠界面
-(void)CKBookMsgViewEventsWithFlag:(NSInteger)flag;
@end

@interface CKBookMsgView : UIView

@property (nonatomic, assign) id<CKBookMsgViewDelegate> delegate;
///显示当前有多少乘客
@property (nonatomic, strong) UILabel *CKNumLB;

@property (nonatomic, strong) NSString *CKNumString;

///显示原价
@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) NSString *priceString;

///显示券标题
@property (nonatomic, strong) UILabel *discountLB;

@property (nonatomic, strong) NSString *discountString;

///显示实际支付价格
@property (nonatomic, strong) UILabel *amoutLB;

@property (nonatomic, strong) NSString *amoutString;

@property (nonatomic, strong) CCMsgModel *model;
///标示是否使用账户余额
@property (nonatomic, strong) UISwitch *mySwitch;


@property (nonatomic, strong) NSDictionary * inputData;

@property (nonatomic, retain) NSMutableArray *stCKData;

@property (nonatomic, retain) ActivityModel *stActModel;

@property (nonatomic, assign) BOOL useWallet;

-(instancetype)initWithFrame:(CGRect)frame inputData:(NSDictionary *)inputData;

@end






