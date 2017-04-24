//
//  CKEditCKMsgViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "YHBaseViewController.h"

@class CKListSingelModel;
@interface CKEditCKMsgViewController : YHBaseViewController

@property (nonatomic, copy)void (^SuccBlock)();

-(instancetype)initWithData:(CKListSingelModel *)dataSoure;

@end
