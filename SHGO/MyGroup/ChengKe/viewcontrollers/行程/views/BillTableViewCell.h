//
//  BillTableViewCell.h
//  SHGO
//
//  Created by 魏亮 on 2017/7/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

@interface BillTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) BillModel *model;

@end
