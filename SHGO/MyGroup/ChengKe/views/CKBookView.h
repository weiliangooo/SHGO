//
//  CKBookView.h
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@class CKBookView;

@protocol CKBookViewDelegate <NSObject>
/// 99:选择拼车 100:选择专车 101:选择乘客数 102:选择优惠 103:使用优惠 104:不使用优惠 105:提交订单
-(void)CKBookView:(CKBookView *)bookView events:(NSInteger)event;

@end

@interface CKBookView : UIView

@property (nonatomic, assign) id<CKBookViewDelegate> delegate;

@property (nonatomic, assign) BOOL isLeft;

@property (nonatomic, assign) BOOL useWallet;

@property (nonatomic, strong) ActivityModel *stActModel;

@property (nonatomic, assign) NSInteger numPs;

@property (nonatomic, strong) NSString *APrice;

-(instancetype)initWithFrame:(CGRect)frame inputData:(NSDictionary *)inputData;


@end







