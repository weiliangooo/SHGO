//
//  PingCarSelectView.h
//  SHGO
//
//  Created by 魏亮 on 2017/6/5.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingCarSelectView : UIView

@property (nonatomic, strong) NSString *priceStr;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, copy) void (^PingCarSelectBlock)();

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title tip:(NSString *)tip;

@end
