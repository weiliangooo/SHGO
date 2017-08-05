//
//  StatusViews.h
//  SHGO
//
//  Created by 魏亮 on 2017/6/14.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusModel.h"


@interface S_StartView : UIView

@property (nonatomic, strong)StatusModel *statusModel;

@property (nonatomic, copy) void (^statusBlock)(NSInteger tag);

-(instancetype)initWithFrame:(CGRect)frame DataSource:(StatusModel *)dic;

@end

@interface S_WatingView : UIView

@property (nonatomic, strong)StatusModel *statusModel;
@property (nonatomic, copy) void (^statusBlock)(NSInteger status);

-(instancetype)initWithFrame:(CGRect)frame DataSource:(StatusModel *)dic;

@end

@interface S_OnWayView : UIView

@property (nonatomic, strong)StatusModel *statusModel;
@property (nonatomic, copy) void (^statusBlock)();

-(instancetype)initWithFrame:(CGRect)frame DataSource:(StatusModel *)dic;

@end






@class S_EndView;
@protocol S_EndViewDelegate <NSObject>

-(void)S_EndView:(S_EndView *)view
             score:(NSString *)score
               text:(NSString *)text;

@end

@interface S_EndView : UIView

@property (nonatomic, assign) id<S_EndViewDelegate> delegate;

@property (nonatomic, copy) void (^statusBlock)(NSInteger tag);

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSDictionary *)dic;

@end
