//
//  ShareView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ShareView.h"
#import "AppDelegate.h"

@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)])
    {
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)]];
        [de.window addSubview:self];
        
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-390*PROPORTION750, AL_DEVICE_WIDTH, 390*PROPORTION750)];
        myView.tag = 1000;
        myView.userInteractionEnabled = YES;
        [myView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
        myView.backgroundColor = [UIColor whiteColor];
        [self addSubview:myView];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        [closeBtn setImage:[UIImage imageNamed:@"pay_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(dismissCurrentView) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:closeBtn];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, 630*PROPORTION750, 30*PROPORTION750)];
        titleLB.text = @"分享到";
        titleLB.font = SYSF750(30);
        titleLB.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:titleLB];
        
        NSArray *images = @[@"wchat_share",@"session_share",@"qq_share",@"qqzone_share"];
        NSArray *tips = @[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间"];
        for (int i = 0; i < 4; i++)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60*PROPORTION750+175*PROPORTION750*i, 90*PROPORTION750, 105*PROPORTION750, 160*PROPORTION750)];
            view.tag = 100+i;
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
            [myView addSubview:view];
            
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.width, view.width)];
            image.clipsToBounds = YES;
            image.layer.cornerRadius = 52.5*PROPORTION750;
            image.image = [UIImage imageNamed:images[i]];
            [view addSubview:image];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 135*PROPORTION750, 105*PROPORTION750, 25*PROPORTION750)];
            label.text = tips[i];
            label.font = SYSF750(25);
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, myView.height-110*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
        button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 15*PROPORTION750;
        [button setTitle:@"取消分享" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = SYSF750(40);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(dismissCurrentView) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button];
        
    }
    return self;
}

-(void)viewTapEvents:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 100:
        {
            self.shareBlock(1);
        }
            break;
        case 101:
        {
            self.shareBlock(2);
        }
            break;
        case 102:
        {
            self.shareBlock(4);
        }
            break;
        case 103:
        {
            self.shareBlock(5);
        }
            break;
        default:
            break;
    }
}

-(void)dismissCurrentView
{
    [self removeFromSuperview];
}

@end
