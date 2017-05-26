//
//  ComplaintViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/5/26.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@interface ComplaintViewController : YHBaseViewController

@property (nonatomic, strong) NSString *orderNum;

@end


@interface CResonCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UIImageView *checkView;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) void (^selectBlock)();

@end
