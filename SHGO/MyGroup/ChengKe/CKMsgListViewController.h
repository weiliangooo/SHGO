//
//  CKMsgListViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/25.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@class MsgModel;
@interface CKMsgListViewController : YHBaseViewController

@end


@interface CKMsgListCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *titleLB;
}
@property (nonatomic, strong) UILabel *contentLB;

@property (nonatomic, copy) MsgModel *model;

@end
