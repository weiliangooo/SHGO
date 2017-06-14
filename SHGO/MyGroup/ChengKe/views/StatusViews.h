//
//  StatusViews.h
//  SHGO
//
//  Created by 魏亮 on 2017/6/14.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface S_StartView : UIView

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSDictionary *)dic;

@end

@interface S_WatingView : UIView

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSDictionary *)dic;

@end

@interface S_OnWayView : UIView

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSDictionary *)dic;

@end






@class S_EndView;
@protocol S_EndViewDelegate <NSObject>

-(void)S_EndView:(S_EndView *)view
             score1:(NSString *)score1
             score2:(NSString *)score2
             score3:(NSString *)score3
             score4:(NSString *)score4
               text:(NSString *)text;

@end

@interface S_EndView : UIView

@property (nonatomic, assign) id<S_EndViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSDictionary *)dic;

@end
