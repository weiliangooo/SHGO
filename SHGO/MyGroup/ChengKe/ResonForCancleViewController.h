//
//  ResonForCancleViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@interface ResonForCancleViewController : YHBaseViewController

@end


@interface ResonCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UIImageView *checkView;

@property (nonatomic, assign) BOOL isSelected;

@end