//
//  CKOrderViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@interface CKOrderViewController : YHBaseViewController

@end


@interface CKOrderCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLB;

@property (nonatomic, strong) UILabel *stateLB;

@property (nonatomic, strong) UILabel *starPlaceLB;

@property (nonatomic, strong) UILabel *endPlaceLB;

@end
