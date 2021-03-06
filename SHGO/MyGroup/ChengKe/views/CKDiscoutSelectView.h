//
//  CKDiscoutSelectView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@class CKDiscoutSelectView;
@protocol DiscoutSelectViewDelegate <NSObject>

-(void)DiscoutSelectView:(CKDiscoutSelectView *)dicoutView selectResult:(ActivityModel *)model;

@end

@class CKDiscoutCell;
@interface CKDiscoutSelectView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id<DiscoutSelectViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray<ActivityModel *> *dataArray;
@property (nonatomic, strong) ActivityModel *stActModel;
@property (nonatomic, strong) UITableView *myTableView;

-(instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)data;

@end



@interface CKDiscoutCell : UITableViewCell

///显示活动标题
@property (nonatomic, strong) UILabel *titleLB;
///提示
@property (nonatomic, strong) UILabel *tipLB;
///显示当前勾选的活动
@property (nonatomic, strong) UISwitch *mySwitch;
///有效时间
@property (nonatomic, strong) UILabel *endLb;

@end
