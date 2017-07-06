//
//  AdvertView.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "AdvertView.h"

@interface AdvertView()
{
    UIButton *skipBtn;
    NSTimer *timer;
    int countTime;
}

@end
@implementation AdvertView

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.image = [UIImage imageNamed:@"LaunchImage"];
        dispatch_queue_t globalQue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQue, ^{
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://m.xiaomachuxing.com/xm/ceshi/img"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [UIImage imageWithData:data];
                
                skipBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-175*PROPORTION750, 60*PROPORTION750, 135*PROPORTION750, 50*PROPORTION750)];
                skipBtn.backgroundColor = RGBA(238, 238, 238, 1);
                skipBtn.clipsToBounds = true;
                skipBtn.layer.cornerRadius = 25*PROPORTION750;
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"3 跳过"];
                [attString addAttribute:NSForegroundColorAttributeName
                                  value: [UIColor colorWithHexString:@"#1aad19"]
                                  range: NSMakeRange(0, 1)];
                [attString addAttribute:NSForegroundColorAttributeName
                                  value: [UIColor blackColor]
                                  range: NSMakeRange(1, attString.length-1)];
                
                [skipBtn setAttributedTitle:attString forState:UIControlStateNormal];
                skipBtn.titleLabel.font = SYSF750(30);
                [skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:skipBtn];
                
                countTime = 4;
                timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                [timer setFireDate:[NSDate distantPast]];
            });
            
        });
        self.userInteractionEnabled = true;
    }
    return self;
}

-(void)skipBtnClick{
    [self removeFromSuperview];
}

-(void)countDown{
    countTime--;
    if (countTime < 0||countTime ==60){
        [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [skipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        [self removeFromSuperview];
    }else{
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d 跳过", countTime]];
        [attString addAttribute:NSForegroundColorAttributeName
                          value: [UIColor colorWithHexString:@"#1aad19"]
                          range: NSMakeRange(0, 1)];
        [attString addAttribute:NSForegroundColorAttributeName
                          value: [UIColor blackColor]
                          range: NSMakeRange(1, attString.length-1)];
        
        [skipBtn setAttributedTitle:attString forState:UIControlStateNormal];
    }
}

@end
