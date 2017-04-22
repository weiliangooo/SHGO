//
//  ChengKePlaceTimeView.h
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CKPlaceTimeViewDelegate <NSObject>

@required
///label点击回调 tag:100 起始位置点击  200:结束位置点击  300:乘车时间点击
-(void)CKPlaceTimeViewClickEvents:(NSInteger )flag;

@end

@interface CKPlaceTimeView : UIView

@property (nonatomic, assign) id<CKPlaceTimeViewDelegate> delegate;
@property (nonatomic, strong) UITextField *timeTF;
@property (nonatomic, strong) UITextField *startPlaceTF;
@property (nonatomic, strong) UITextField *endPlaceTF;

@end
