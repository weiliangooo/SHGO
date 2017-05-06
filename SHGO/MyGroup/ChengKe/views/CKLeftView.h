//
//  ChengKeLeftView.h
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBaseViewController.h"

@class CKLeftCell;
@class CKLeftHeadView;
@class CKLeftFootView;
@class CKLeftView;

@protocol CKLeftViewDelegate <NSObject>

-(void)CKLeftView:(CKLeftView *)leftView didSelectFlag:(NSInteger)flag;

@end

@interface CKLeftView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id<CKLeftViewDelegate> delegate;

@property (nonatomic, strong) CKLeftHeadView *myTableHead;

-(instancetype)initWithViewController:(YHBaseViewController *)viewController;

-(void)showView;

-(void)hiddenView;

-(void)hiddenViewAtonce;

@end

@interface CKLeftCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImage;

@property (nonatomic, strong) UILabel *titleLB;

@end

@interface CKLeftHeadView : UIView
///头像
@property (nonatomic, strong)UIImageView *headView;
///电话号码
@property (nonatomic, strong)UILabel *phoneLB;
///签到按钮
@property (nonatomic, strong)UIButton *signBtn;

-(void)setUpSignBtnStauts:(BOOL)isSelected;

@end


@interface CKLeftFootView : UIView

@end
