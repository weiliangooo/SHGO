//
//  OrderDetailBaseView.h
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OrederStatusNoPay,
    OrederStatusSystemCancle,
    OrederStatusCancle,
    OrederStatusRefund,
    OrederStatusCarPay,
    OrederStatusHadPay,
    OrederStatusHadCar,
    OrederStatusFinished,
    OrederStatusHadCommed,
} OrederStatus;

@protocol OrderDetailBaseViewDelgate <NSObject>

-(void)OrderDetailBaseViewClickWithTitle:(NSString *)title;

@end

@class OrderDetailModel;

@interface OrderDetailBaseView : UIView

@property (nonatomic, assign) id<OrderDetailBaseViewDelgate> delegate;

@property (nonatomic, strong) UIScrollView *scollerView;

@property (nonatomic, strong) UIView *orderMsgView;

@property (nonatomic, strong) UILabel *startLB;

@property (nonatomic, strong) UILabel *endLB;

@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) UILabel *ckLB;

@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) OrderDetailModel *model;

+(OrderDetailBaseView *)orderDetailViewWithType:(OrederStatus )type;

-(void)setModel:(OrderDetailModel *)model;

-(void)setPriceString:(NSString *)string;

-(void)buttonClickEvents:(UIButton *)button;

@end
