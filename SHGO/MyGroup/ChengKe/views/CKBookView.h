//
//  CKBookView.h
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCMsgModel.h"

@class CKBookMsgView;

@protocol CKBookViewDelegate <NSObject>

@required

///点击立即预订  返回乘客成员信息
-(void)CKBookViewBackWithCKMsg:(NSMutableArray *)ckMsg;
///加载乘客成员选择界面
-(void)CKBookViewForMoreBtnClickEventWithCKMsg:(NSMutableArray *)ckMsg flag:(NSInteger)flag;

@end

@interface CKBookView : UIView

@property (nonatomic, assign) id<CKBookViewDelegate> delegate;

@property (nonatomic, strong) CKBookMsgView *ckBookMsgView;



@end




@interface CKBookMsgView : UIView

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

///flag 1:展示选择乘客界面。2:展示选择优惠界面
@property (nonatomic, copy) void (^AddOrMoreBtnBlock)(NSInteger flag);

@end






