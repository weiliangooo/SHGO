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
    OrederStatusCancle = 10,
    OrederStatusRefund = 20,
    OrederStatusCarPay = 25,
    OrederStatusHadPay = 30,
    OrederStatusHadSend,
    OrederStatusHadCar = 40,
    OrederStatusFinished,
    OrederStatusHadCommed,
} OrederStatus;

@protocol OrderDetailBaseViewDelgate <NSObject>

-(void)OrderDetailBaseViewClickWithTitle:(NSString *)title;

@end

@class OrderDetailModel;
@class MyStar;

@interface OrderDetailBaseView : UIView

@property (nonatomic, assign) id<OrderDetailBaseViewDelgate> delegate;

@property (nonatomic, strong) UIScrollView *scollerView;

@property (nonatomic, strong) UIView *orderMsgView;
/*订单信息*/
@property (nonatomic, strong) UILabel *startLB;

@property (nonatomic, strong) UILabel *endLB;

@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) UILabel *ckLB;

@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) OrderDetailModel *model;

/*车人信息*/
@property (nonatomic, strong) UILabel *driverNameLB;

@property (nonatomic, strong) MyStar *starView;

@property (nonatomic, strong) UILabel *carNameLB;

@property (nonatomic, strong) UILabel *carNumLB;


+(OrderDetailBaseView *)orderDetailViewWithType:(OrederStatus )type;

-(void)setModel:(OrderDetailModel *)model;

-(void)setPriceString:(NSString *)string;

-(void)buttonClickEvents:(UIButton *)button;

@end
