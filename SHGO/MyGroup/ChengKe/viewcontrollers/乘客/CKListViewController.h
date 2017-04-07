//
//  CKListViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@interface CKListViewController : YHBaseViewController

@end


@interface CKListCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLB;

@property (nonatomic, strong) UILabel *idLB;

@property (nonatomic, strong) UILabel *phoneLB;

@property (nonatomic, strong) UIButton *changeBtn;

@property (nonatomic, copy) void (^changeBlock)();

@end
