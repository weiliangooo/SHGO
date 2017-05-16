//
//  ADView.h
//  SHGO
//
//  Created by 魏亮 on 2017/5/16.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) void (^imageTapBlock)();

@end
