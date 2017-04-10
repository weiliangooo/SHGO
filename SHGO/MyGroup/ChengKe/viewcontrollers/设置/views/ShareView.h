//
//  ShareView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property (nonatomic, copy) void (^shareBlock)(NSInteger flag);

@end
