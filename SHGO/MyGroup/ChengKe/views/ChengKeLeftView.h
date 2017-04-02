//
//  ChengKeLeftView.h
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBaseViewController.h"

@class CKLeftHeadView;
@class CKLeftFootView;

@interface ChengKeLeftView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) CKLeftHeadView *myTableHead;

@property (nonatomic, strong) CKLeftFootView *myTableFoot;

-(instancetype)initWithFrame:(CGRect)frame withViewController:(YHBaseViewController *)viewController;

@end

@interface CKLeftHeadView : UIView
///头像
@property (nonatomic, strong)UIImageView *headView;
///电话号码
@property (nonatomic, strong)UILabel *phoneLB;
///签到按钮
@property (nonatomic, strong)UIButton *signBtn;

@end


@interface CKLeftFootView : UIView

@property (nonatomic, copy) void (^phoneOfKFBlock)(NSString *phoneNum);

@end
