//
//  SignAlertView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "SignAlertView.h"
#import "UIImage+ScalImage.h"

@implementation SignAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithTipTitle:(NSString *)title
{
    if (self = [super init])
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(95*PROPORTION750, (AL_DEVICE_HEIGHT-340*PROPORTION750)/2, 560*PROPORTION750, 340*PROPORTION750)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.clipsToBounds = YES;
        backView.layer.cornerRadius = 15*PROPORTION750;
        backView.userInteractionEnabled = YES;
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(printHH)]];
        [self addSubview:backView];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(backView.right-50*PROPORTION750, backView.top-85*PROPORTION750, 50*PROPORTION750, 50*PROPORTION750)];
        closeBtn.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"closeBtn"];
        [closeBtn setImage:[image scaleImageByWidth:100*PROPORTION750] forState:UIControlStateNormal];
//        [closeBtn setImage:image forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(backView.left-10*PROPORTION750, backView.top+30*PROPORTION750, 250*PROPORTION750, 45*PROPORTION750)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"signBg"];
        [self addSubview:imageView];
        
        UIImageView *tipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(225*PROPORTION750, 105*PROPORTION750, 110*PROPORTION750, 100*PROPORTION750)];
        tipImgView.image = [UIImage imageNamed:@"sign_succ"];
        [backView addSubview:tipImgView];
        
        UILabel *tip1 = [[UILabel alloc]initWithFrame:CGRectMake(0, tipImgView.bottom+30*PROPORTION750, backView.width, 25*PROPORTION750)];
        tip1.text = @"签到成功";
        tip1.textColor = [UIColor colorWithHexString:@"1aad19"];
        tip1.font = SYSF750(25);
        tip1.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:tip1];
        
        UILabel *tip2 = [[UILabel alloc]initWithFrame:CGRectMake(0, tip1.bottom+30*PROPORTION750, backView.width, 25*PROPORTION750)];
        tip2.text = title;
        tip2.textColor = [UIColor colorWithHexString:@"1aad19"];
        tip2.font = SYSF750(25);
        tip2.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:tip2];
    }
    return self;
}
-(void)closeBtnClickEvent
{
    [self removeFromSuperview];
}

-(void)printHH
{
    NSLog(@"HH");
}

-(void)dissMissCurrent
{
    NSLog(@"HH");
}


@end
