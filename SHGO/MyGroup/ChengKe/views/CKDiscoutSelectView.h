//
//  CKDiscoutSelectView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CKDiscoutHeadView;
@class CKDiscoutCell;
@interface CKDiscoutSelectView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *myTableView;

@end


@interface CKDiscoutHeadView : UIView

///点击返回的事件
@property (nonatomic, copy) void (^backBlock)();

@end


@interface CKDiscoutCell : UITableViewCell

///显示活动标题
@property (nonatomic, strong) UILabel *titleLB;
///显示当前勾选的活动
@property (nonatomic, strong) UISwitch *mySwitch;

@end
