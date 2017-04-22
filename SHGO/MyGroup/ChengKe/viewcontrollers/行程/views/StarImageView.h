//
//  StarImageView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    StarImageViewStatusOff,
    StarImageViewStatusHalf,
    StarImageViewStatusOn,
} StarImageViewStatus;

@interface StarImageView : UIImageView

@property (nonatomic, assign) StarImageViewStatus curStatus;

@end
