//
//  CKBookView.h
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKBookMsgView;

@protocol CKBookViewDelegate <NSObject>

@required

///点击立即预订  返回乘客成员信息
-(void)CKBookViewBackWithCKMsg:(NSMutableArray *)ckMsg;
///加载乘客成员选择界面
-(void)CKBookViewForMoreBtnClickEventWithCKMsg:(NSMutableArray *)ckMsg;

@end

@interface CKBookView : UIView

@property (nonatomic, assign) id<CKBookViewDelegate> delegate;

@property (nonatomic, strong) CKBookMsgView *ckBookMsgView;


@end




@interface CKBookMsgView : UIView

@property (nonatomic, copy) void (^AddOrMoreBtnBlock)();

@end






