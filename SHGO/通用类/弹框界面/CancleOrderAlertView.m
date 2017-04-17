//
//  CancleOrderAlertView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CancleOrderAlertView.h"

@implementation CancleOrderAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithTipTitle:(NSString *)title TipImage:(NSString *)tipImage
{
    if(self = [super init])
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, (AL_DEVICE_HEIGHT-305*PROPORTION750)/2, 710*PROPORTION750, 305*PROPORTION750)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.clipsToBounds = YES;
        backView.layer.cornerRadius = 15*PROPORTION750;
        backView.userInteractionEnabled = YES;
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(printHH)]];
        [self addSubview:backView];
        
        UIImageView *tipImgView = [[UIImageView alloc]initWithFrame:CGRectMake(302.5*PROPORTION750, 30*PROPORTION750, 105*PROPORTION750, 105*PROPORTION750)];
        tipImgView.clipsToBounds = YES;
        tipImgView.layer.cornerRadius = 57.5*PROPORTION750;
        tipImgView.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        [backView addSubview:tipImgView];
        if(tipImage == nil)
        {
        
        }
        else
        {
            
        }
        
        UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 165*PROPORTION750, self.width, 30*PROPORTION750)];
        tipLB.text = title;
        tipLB.textColor = [UIColor colorWithHexString:@"#1aad19"];
        tipLB.font = SYSF750(30);
        tipLB.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:tipLB];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(180*PROPORTION750, tipLB.bottom+40*PROPORTION750, 130*PROPORTION750, 40*PROPORTION750)];
        sureBtn.tag = 100;
        sureBtn.backgroundColor = [UIColor whiteColor];
        sureBtn.clipsToBounds = YES;
        sureBtn.layer.cornerRadius = 8*PROPORTION750;
        sureBtn.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
        sureBtn.layer.borderWidth = 2*PROPORTION750;
        [sureBtn setTitle:@"是" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = SYSF750(30);
        [sureBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:sureBtn];
        
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(sureBtn.right+80*PROPORTION750, tipLB.bottom+40*PROPORTION750, 130*PROPORTION750, 40*PROPORTION750)];
        cancleBtn.tag = 200;
        cancleBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        cancleBtn.clipsToBounds = YES;
        cancleBtn.layer.cornerRadius = 8*PROPORTION750;
        [cancleBtn setTitle:@"否" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = SYSF750(30);
        [cancleBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:cancleBtn];

    }
    return self;
}

-(void)buttonClickEvents:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
    {
        [self.delegate AlertClassView:self clickIndex:button.tag];
    }
}

-(void)printHH
{
    NSLog(@"HH");
}

@end
