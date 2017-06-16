//
//  UpCommenView.m
//  SHGO
//
//  Created by Alen on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "UpCommenView.h"
#import "AppDelegate.h"
#import "MyStar.h"
#import "UIImage+ScalImage.h"

@interface UpCommenView()<UITextViewDelegate>
{
    UILabel *tvTipLB;
}

@property (nonatomic, strong) MyStar *starView1;

@property (nonatomic, strong) MyStar *starView2;

@property (nonatomic, strong) MyStar *starView3;

@property (nonatomic, strong) MyStar *starView4;

@property (nonatomic, strong) UITextView *pjTextView;

@end
@implementation UpCommenView

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [de.window addSubview:self];
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-100*PROPORTION750, AL_DEVICE_HEIGHT-890*PROPORTION750, 80*PROPORTION750, 80*PROPORTION750)];
        closeBtn.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"closeBtn"];
        [closeBtn setImage:[image scaleImageByWidth:100*PROPORTION750] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, AL_DEVICE_HEIGHT-790*PROPORTION750, 710*PROPORTION750, 760*PROPORTION750)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.clipsToBounds = true;
        backView.layer.cornerRadius = 15*PROPORTION750;
        [self addSubview:backView];
        
        UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.width, 100*PROPORTION750)];
        tipLB.text = @"评价";
        tipLB.font = SYSF750(30);
        tipLB.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:tipLB];
        
        _starView1 = [[MyStar alloc] initWithFrame:CGRectMake(45*PROPORTION750, 120*PROPORTION750, 600*PROPORTION750, 80*PROPORTION750) space:50*PROPORTION750];
        [_starView1 setScore:0.0];
        _starView1.isCanTap = true;
        [self addSubview:_starView1];
        
//        UILabel *tip1 = [[UILabel alloc] initWithFrame:CGRectMake(100*PROPORTION750, tipLB.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
//        tip1.text = @"服务态度";
//        tip1.font = SYSF750(30);
//        tip1.textAlignment = NSTextAlignmentLeft;
//        [backView addSubview:tip1];
//        [tip1 sizeToFit];
//        CGFloat starViewSpace = (470*PROPORTION750-tip1.width)/5-40*PROPORTION750;
//        CGFloat starViewWidth = 470*PROPORTION750-tip1.width + starViewSpace;
//        
//        _starView1 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tipLB.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
//        [_starView1 setScore:5.0];
//        _starView1.isCanTap = true;
//        [backView addSubview:_starView1];
//        
//        UILabel *tip2 = [[UILabel alloc] initWithFrame:CGRectMake(100*PROPORTION750, tip1.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
//        tip2.text = @"车辆整洁";
//        tip2.font = SYSF750(30);
//        tip2.textAlignment = NSTextAlignmentLeft;
//        [backView addSubview:tip2];
//        [tip1 sizeToFit];
//        
//        _starView2 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tip1.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
//        _starView2.isCanTap = true;
//        [_starView2 setScore:5.0];
//        [backView addSubview:_starView2];
//        
//        UILabel *tip3 = [[UILabel alloc] initWithFrame:CGRectMake(100*PROPORTION750, tip2.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
//        tip3.text = @"驾驶技术";
//        tip3.font = SYSF750(30);
//        tip3.textAlignment = NSTextAlignmentLeft;
//        [backView addSubview:tip3];
//        [tip1 sizeToFit];
//        
//        _starView3 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tip2.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
//        _starView3.isCanTap = true;
//        [_starView3 setScore:5.0];
//        [backView addSubview:_starView3];
//        
//        UILabel *tip4 = [[UILabel alloc] initWithFrame:CGRectMake(100*PROPORTION750, tip3.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
//        tip4.text = @"线路熟悉";
//        tip4.font = SYSF750(30);
//        tip4.textAlignment = NSTextAlignmentLeft;
//        [backView addSubview:tip4];
//        [tip1 sizeToFit];
//        
//        _starView4 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tip3.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
//        _starView4.isCanTap = true;
//        [_starView4 setScore:5.0];
//        [backView addSubview:_starView4];
        
        _pjTextView = [[UITextView alloc] initWithFrame:CGRectMake(100*PROPORTION750, /*tip4.bottom+30*PROPORTION750*/320*PROPORTION750, 510*PROPORTION750, 200*PROPORTION750)];
        _pjTextView.clipsToBounds = true;
        _pjTextView.layer.cornerRadius = 15*PROPORTION750;
        _pjTextView.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
        _pjTextView.layer.borderWidth = 2*PROPORTION750;
        _pjTextView.font = SYSF750(25);
        _pjTextView.delegate = self;
        _pjTextView.returnKeyType = UIReturnKeyDone;
        [backView addSubview:_pjTextView];
        
        tvTipLB = [[UILabel alloc] initWithFrame:CGRectMake(5*PROPORTION750, 15*PROPORTION750, 500*PROPORTION750, 30*PROPORTION750)];
        tvTipLB.text = @"评价一下此次行程吧，您的的意见很重要！";
        tvTipLB.textColor = [UIColor colorWithHexString:@"999999"];
        tvTipLB.font = SYSF750(25);
        tvTipLB.textAlignment = NSTextAlignmentLeft;
        [_pjTextView addSubview:tvTipLB];
        
        UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, _pjTextView.bottom+30*PROPORTION750, 650*PROPORTION750, 90*PROPORTION750)];
        upBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        upBtn.clipsToBounds = YES;
        upBtn.layer.cornerRadius = 15*PROPORTION750;
        [upBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        upBtn.titleLabel.font = SYSF750(35);
        upBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [upBtn addTarget:self action:@selector(buttonClickEvent) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:upBtn];
        
        //注册键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        //注册键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        tvTipLB.hidden = false;
    }else{
        tvTipLB.hidden = true;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [_pjTextView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

-(void)keyboardWasShown:(NSNotification*)aNotification{
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyBoardFrame.origin.y < _pjTextView.bottom+AL_DEVICE_HEIGHT-790*PROPORTION750){
        [UIView animateWithDuration:1.0f animations:^{
            self.frame = CGRectMake(0, -(-keyBoardFrame.origin.y+_pjTextView.bottom+AL_DEVICE_HEIGHT-790*PROPORTION750), AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        }];
    }
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    [UIView animateWithDuration:1.0f animations:^{
        self.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
    }];
    
}

-(void)buttonClickEvent{
    if ([_starView1 getScore] == 0) {
        MBProgressHUD *toastHUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:toastHUD];
        toastHUD.labelText = @"您还没有为司机评分";
        toastHUD.mode = MBProgressHUDModeText;
        
        [toastHUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            [toastHUD removeFromSuperview];
        }];
        return;
    }
    NSString *score = [_starView1 getScore];
    NSString *content = _pjTextView.text;

    if (_delegate && [_delegate respondsToSelector:@selector(upCommenView:score:text:)]) {
        [_delegate upCommenView:self
                         score:score
                           text:content];
    }
}

-(void)closeBtnClickEvent{
    [self removeFromSuperview];
}

@end
