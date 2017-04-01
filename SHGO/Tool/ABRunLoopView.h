//
//  ABRunLoopView.h
//  RentOutProject
//
//  Created by Abel on 16/6/27.
//  Copyright © 2016年 Abel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABRunLoopView : UIView

/** 本地图片数组*/
@property (nonatomic,strong) NSArray *imgArray;
/** 网络图片数组*/
@property (nonatomic,strong) NSArray *URLimgArray;
/** 图片点击调用*/
- (void)touchImageIndexBlock:(void (^)(NSInteger index))block;

- (instancetype)initWithFrame:(CGRect)frame placeholderImg:(UIImage *)img;

-(void)stopTimer;

@end
