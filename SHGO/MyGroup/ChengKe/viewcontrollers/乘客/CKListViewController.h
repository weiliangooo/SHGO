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

@property (nonatomic, strong) NSString *ckName;

@property (nonatomic, strong) NSString *ckId;

@property (nonatomic, strong) NSString *ckPhone;

@property (nonatomic, strong) UIButton *changeBtn;

@property (nonatomic, copy) void (^changeBlock)();

@end
