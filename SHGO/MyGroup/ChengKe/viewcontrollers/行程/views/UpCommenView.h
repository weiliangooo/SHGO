//
//  UpCommenView.h
//  SHGO
//
//  Created by Alen on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpCommenView;
@protocol UpCommenViewDelegate <NSObject>

-(void)upCommenView:(UpCommenView *)view score1:(CGFloat)score1 score2:(CGFloat)score2 score3:(CGFloat)score3 score4:(CGFloat)score4 text:(NSString *)text;

@end

@interface UpCommenView : UIView

@property (nonatomic, assign) id<UpCommenViewDelegate> delegate;

@end
