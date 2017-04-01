//
//  ChengKePlaceTimeView.h
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChengKePlaceTimeView : UIView

@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) UILabel *startPlaceLB;
@property (nonatomic, strong) UILabel *endPlaceLB;
///label点击回调 tag:100 起始位置点击  200:结束位置点击  300:乘车时间点击
@property (nonatomic, copy)void (^CKPTBlock)(NSInteger tag);


@end
