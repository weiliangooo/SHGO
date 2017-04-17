//
//  AlertClassView.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertClassDelegate <NSObject>

-(void)AlertClassView:(id)alertView clickIndex:(NSInteger)index;

@end

@interface AlertClassView : UIView

@property (nonatomic, weak)id<AlertClassDelegate> delegate;

-(void)dissMissCurrent;

@end
