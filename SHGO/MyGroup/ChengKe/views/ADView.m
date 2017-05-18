//
//  ADView.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/16.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ADView.h"
#import "AppDelegate.h"
#import "UIImage+ScalImage.h"

@implementation ADView

-(instancetype)init{
    if (self = [super init]) {
        AppDelegate *de = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [de.window addSubview:self];
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60*PROPORTION750, (AL_DEVICE_HEIGHT-660*PROPORTION750)/2, 630*PROPORTION750, 660*PROPORTION750)];
        _imageView.clipsToBounds = true;
        _imageView.layer.cornerRadius = 15*PROPORTION750;
        _imageView.userInteractionEnabled = true;
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)]];
        [self addSubview:_imageView];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH/2-40*PROPORTION750, _imageView.bottom+80*PROPORTION750, 80*PROPORTION750, 80*PROPORTION750)];
        closeBtn.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"closeBtn"];
        [closeBtn setImage:[image scaleImageByWidth:100*PROPORTION750] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
    }
    return self;
}

-(void)viewTap{
    [self removeFromSuperview];
    self.imageTapBlock();
}

-(void)closeBtnClickEvent{
    [self removeFromSuperview];
}

@end
