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

@interface CKLeftView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) CKLeftHeadView *myTableHead;

@property (nonatomic, strong) CKLeftFootView *myTableFoot;

@property (nonatomic, copy) void (^didSelectedBlock)(NSInteger row);

-(instancetype)initWithFrame:(CGRect)frame withViewController:(YHBaseViewController *)viewController;

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
///签到和头像点击的回调函数 flag : 1 点击头像  2 点击签到按钮
@property (nonatomic, copy)void (^leftHeadBlock)(NSInteger flag);

-(void)setUpSignBtnStauts:(BOOL)isSelected;

@end


@interface CKLeftFootView : UIView

@property (nonatomic, copy) void (^phoneOfKFBlock)(NSString *phoneNum);

@end
