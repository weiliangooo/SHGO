//
//  PopAleatView.m
//  Market
//
//  Created by yangH4 on 15/12/30.
//  Copyright © 2015年 yingzhen. All rights reserved.
//

#import "PopAleatView.h"

@interface PopAleatView ()
{
    UIButton *_creatGroup;
    UIButton *_searchGroup;
    UIWindow *_keyWindow;
    UITapGestureRecognizer *_singleTapGR;
}

@property(nonatomic)UIView *creatBg;
@end


@implementation PopAleatView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        [self initView];
        [UIView animateWithDuration:0.5 animations:^{
            self.creatBg.frame =  CGRectMake(0,AL_DEVICE_HEIGHT-150, AL_DEVICE_HEIGHT, 150);
        }];
        
    }
    return self;
}
-(void)initView{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    
    _keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!_keyWindow) {
        _keyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    [_keyWindow addSubview:self];
    _singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(popViewHidden)];
    [self addGestureRecognizer:_singleTapGR];
}

-(void)setButtonStr1:(NSString *)str1 Str2:(NSString *)str2{
    _creatBg=[[UIView alloc]initWithFrame:CGRectMake(0, self.size.height, self.size.width, 60+2*45)];
    [_creatBg setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_creatBg];
    UIView *group=[[UIView alloc]initWithFrame:CGRectMake(6, 0, _creatBg.size.width-12, 2*45)];
    [group setBackgroundColor:[UIColor whiteColor]];
    [group.layer setCornerRadius:5];
    [_creatBg addSubview:group];
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake(6, group.size.height+5, group.size.width, 45)];
    [cancel.layer setCornerRadius:5];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor colorWithRed:0 green:0.62 blue:1 alpha:1]  forState:UIControlStateNormal];
    [cancel.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [cancel setBackgroundColor:[UIColor whiteColor]];
    [cancel addTarget:self action:@selector(cancelBnt) forControlEvents:UIControlEventTouchUpInside];
    [_creatBg addSubview:cancel];
    [UIView animateWithDuration:0.5 animations:^{
        self.creatBg.frame =  CGRectMake(0,AL_DEVICE_HEIGHT-(60+2*45), AL_DEVICE_HEIGHT, 60+2*45);
    }];
    for (int i=0; i<2; i++) {
        UIButton *bnt=[[UIButton alloc]initWithFrame:CGRectMake(0, i*45, group.size.width, 45)];
        if (i==0) {
            [bnt setTitle:str1 forState:UIControlStateNormal];
        }else{
            [bnt setTitle:str2 forState:UIControlStateNormal];
        }
        
        [bnt setTag:i];
        [bnt addTarget:self action:@selector(onClickBnt:) forControlEvents:UIControlEventTouchUpInside];
        [bnt setTitleColor:[UIColor colorWithRed:0 green:0.62 blue:1 alpha:1]  forState:UIControlStateNormal];
        [bnt.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [group addSubview:bnt];
        if ((i+1)<2) {
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 44.5,group.size.width , 0.5)];
            [line setBackgroundColor:[UIColor colorWithRed:0.745 green:0.745 blue:0.745 alpha:1]];
            [bnt addSubview:line];
        }
    }
}

-(void)onClickBnt:(UIButton *)sender{
    [_keyWindow removeGestureRecognizer:_singleTapGR];
    [UIView animateWithDuration:0.5 animations:^{
        _creatBg.frame =  CGRectMake(0,AL_DEVICE_HEIGHT, AL_DEVICE_HEIGHT, 150);
        [self removeFromSuperview];
    }];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(onClick: setbtn:popAleatView:)]) {
//        [self.delegate onClick:sender setbtn:self.btn];
        [self.delegate onClick:sender setbtn:self.btn popAleatView:self];
    }
}

//取消创建
-(void)cancelBnt{
    [_keyWindow removeGestureRecognizer:_singleTapGR];
    [UIView animateWithDuration:0.5 animations:^{
        _creatBg.frame =  CGRectMake(0,AL_DEVICE_HEIGHT, AL_DEVICE_HEIGHT, 150);
        [self removeFromSuperview];
    }];
}
-(void)popViewHidden{
    [_keyWindow removeGestureRecognizer:_singleTapGR];
    [UIView animateWithDuration:0.5 animations:^{
        self.creatBg.frame =  CGRectMake(0,AL_DEVICE_HEIGHT, AL_DEVICE_HEIGHT, 150);
        [self removeFromSuperview];
    }];
    
}

@end
