//
//  CurrentStatusViewController.h
//  SHGO
//
//  Created by 魏亮 on 2017/6/12.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKMapViewController.h"

typedef enum : NSUInteger {
    s_start,
    s_waiting,
    s_onWay,
    s_end,
} CurStatus;

@interface CurrentStatusViewController : CKMapViewController

@property (nonatomic, assign)CurStatus curStatus;
@property (nonatomic, assign)CurStatus willStatus;

-(void)refreshCurUI;

@end
