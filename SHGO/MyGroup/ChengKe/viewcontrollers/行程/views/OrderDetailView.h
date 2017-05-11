//
//  OrderDetailView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    OrderDetailViewEventPhone = 101,
    OrderDetailViewEventDetail = 102,
    OrderDetailViewEventShare = 103,
//    OrderDetailViewEventShare = 104,
} OrderDetailViewEvent;


@class OrderDetailModel;
@class OrderDetailView;

@protocol OrderDetailDelegate <NSObject>

-(void)orderDetailView:(OrderDetailView *)orderDetailView ClickEvents:(OrderDetailViewEvent)event inputString:(NSString *)inputString;

@end

@interface OrderDetailView : UIView

@property (nonatomic, assign) id<OrderDetailDelegate> delegate;

@property (nonatomic, copy) OrderDetailModel *orderDetailModel;

@end
