//
//  RefundView.h
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderDetailModel;
@class ckModel;

@interface RefundView : UIView

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) void (^dataBlock)(ckModel *model, UIButton *button);

@end


@interface RefundCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UIButton *refundBtn;

@property (nonatomic, strong) ckModel *model;

@property (nonatomic, copy) void (^buttonClick)(UIButton *button);

@end
