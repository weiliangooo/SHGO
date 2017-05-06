//
//  ChengKeMainViewController.h
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@class CCMsgModel;
@interface CKMainViewController : YHBaseViewController
///用来盛放用户乘车信息的model
@property (nonatomic, strong)CCMsgModel *ccMsgModel;

@end
