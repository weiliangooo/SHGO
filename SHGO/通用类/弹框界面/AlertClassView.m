//
//  AlertClassView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "AlertClassView.h"
#import "AppDelegate.h"

@implementation AlertClassView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if(self = [super init])
    {
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissMissCurrent)]];
        [de.window addSubview:self];
    }
    return self;
}

-(void)dissMissCurrent
{
    [self removeFromSuperview];
}

@end
