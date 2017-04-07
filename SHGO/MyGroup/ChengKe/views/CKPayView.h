//
//  CKPayView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CKPayCell;

@protocol CKPayViewDelegate <NSObject>

-(void)CKPayViwePayBtnClickEvent;

@end

@interface CKPayView : UIView

@property (nonatomic, assign) id<CKPayViewDelegate> delegate;

@end


@interface CKPayCell : UIView


///付款方式的图片
@property (nonatomic, strong) UIImageView *headImage;
///标示当前付款方式
@property (nonatomic, strong) UILabel *titleLB;
///当前付款方式 是否被选中
@property (nonatomic, assign) BOOL isSelected;
///点击勾选按钮触发block
@property (nonatomic, copy) void (^selectedBlock)();

@end
