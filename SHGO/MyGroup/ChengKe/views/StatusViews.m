//
//  StatusViews.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/14.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "StatusViews.h"
#import "MyStar.h"
#import "UIImage+ScalImage.h"
#import "UpCommenView.h"

@implementation S_StartView

-(instancetype)initWithFrame:(CGRect)frame DataSource:(StatusModel *)dic{
    if (self = [super initWithFrame:frame]) {
        _statusModel = dic;
//        UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-240*PROPORTION750-64, 690*PROPORTION750, 220*PROPORTION750)];
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15*PROPORTION750;
        
        UILabel * _startEndCityLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 298*PROPORTION750, 30*PROPORTION750)];
        _startEndCityLB.text = [NSString stringWithFormat:@"%@——>%@", _statusModel.start_address_name, _statusModel.end_address_name];
        _startEndCityLB.textColor = [UIColor colorWithHexString:@"#999999"];
        _startEndCityLB.font = SYSF750(30);
        [self addSubview:_startEndCityLB];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(318*PROPORTION750, 30*PROPORTION750, 2*PROPORTION750, 30*PROPORTION750)];
        line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:line1];
        
        UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(line1.right+15*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        timeImage.image = [UIImage imageNamed:@"time"];
        [self addSubview:timeImage];
        
        UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right, 30*PROPORTION750, 305*PROPORTION750, 30*PROPORTION750)];
        timeLB.text = [NSString stringWithFormat:@"%@ 出发", [MyHelperTool timeSpToTime:_statusModel.start_unixtime]];
//        timeLB.text = [NSString stringWithFormat:@"%@ 出发",@"2017-06-14-09:00"];
        timeLB.textColor = [UIColor colorWithHexString:@"#999999"];
        timeLB.font = SYSF750(25);
        [self addSubview:timeLB];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:line2];
        
        //            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //            [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        //            NSDate *date = [formatter dateFromString:_startTime];
        //            NSTimeInterval timeInterval = [date timeIntervalSince1970];
        //            NSString *start2 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(timeInterval - 3600)]];
        
        
        UILabel *msgLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line2.bottom+30*PROPORTION750, 630*PROPORTION750, 70*PROPORTION750)];
        msgLB.font = SYSF750(25);
        msgLB.numberOfLines = 2;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"系统将于%@为您派单，并安排司机来接您，请留意手机提醒并保持手机畅通。", [MyHelperTool timeSpToTime:[NSString stringWithFormat:@"%d", [_statusModel.start_unixtime intValue]-3600]]]];
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"系统将于%@为您派单，并安排司机来接您，请留意手机提醒并保持手机畅通。", @"2017-06-14-08:00"]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithHexString:@"999999"]
                              range:NSMakeRange(0, 4)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithHexString:@"#1ead1a"]
                              range:NSMakeRange(4, 16)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithHexString:@"999999"]
                              range:NSMakeRange(20, AttributedStr.length-20)];
        msgLB.attributedText = AttributedStr;
        [self addSubview:msgLB];
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 218*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line3.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:line3];
        
        NSMutableAttributedString *AttrBtn = [[NSMutableAttributedString alloc] initWithString:@"如需取消，请拨400-966-3655"];
        [AttrBtn addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithHexString:@"999999"]
                              range:NSMakeRange(0, 7)];
        [AttrBtn addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithHexString:@"#1ead1a"]
                              range:NSMakeRange(7, 12)];
        
        UIButton *canCleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, line3.bottom, 690*PROPORTION750, 90*PROPORTION750)];
//        [canCleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
//        [canCleBtn setTitle:@"如需取消，请拨400-966-3655" forState:UIControlStateNormal];
        [canCleBtn setAttributedTitle:AttrBtn forState:UIControlStateNormal];
        [canCleBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        canCleBtn.titleLabel.font = SYSF750(30);
        [canCleBtn addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:canCleBtn];
        
    }
    return self;
}

-(void)cancleEvent{
    self.statusBlock();
}

@end

@implementation S_WatingView

-(instancetype)initWithFrame:(CGRect)frame DataSource:(StatusModel *)dic{
    if (self = [super initWithFrame:frame]) {
        _statusModel = dic;
//        UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-450*PROPORTION750-64, 690*PROPORTION750, 430*PROPORTION750)];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15*PROPORTION750;
        
        MyStar *starView = [[MyStar alloc] initWithFrame:CGRectMake(182.5*PROPORTION750, 160*PROPORTION750, 325*PROPORTION750, 45*PROPORTION750) space:20*PROPORTION750];
        [starView setScore:(CGFloat)[_statusModel.score doubleValue]];
        [self addSubview:starView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 230*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
        UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, line.bottom+30*PROPORTION750, 170*PROPORTION750, 40*PROPORTION750)];
        phoneBtn.tag = 100;
        [phoneBtn setImage:[[UIImage imageNamed:@"detail"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
        [phoneBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        [phoneBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        phoneBtn.titleLabel.font = SYSF750(25);
        phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 130*PROPORTION750);
        phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [phoneBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phoneBtn];
        
        UIButton *msgBtn = [[UIButton alloc] initWithFrame:CGRectMake(490*PROPORTION750, line.bottom+30*PROPORTION750, 170*PROPORTION750, 40*PROPORTION750)];
        msgBtn.tag = 200;
        [msgBtn setImage:[[UIImage imageNamed:@"message"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
        [msgBtn setTitle:@"发送信息" forState:UIControlStateNormal];
        [msgBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        msgBtn.titleLabel.font = SYSF750(25);
        msgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 130*PROPORTION750);
        msgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [msgBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:msgBtn];
        
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 330*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line2];
        
        UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, line2.bottom+30*PROPORTION750, 690*PROPORTION750, 40*PROPORTION750)];
        shareBtn.tag = 300;
        [shareBtn setImage:[[UIImage imageNamed:@"share_icon"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
        [shareBtn setTitle:@" 分享获得优惠券" forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        shareBtn.titleLabel.font = SYSF750(30);
        [shareBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        //            shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 130*PROPORTION750);
        //            shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:shareBtn];
    }
    return self;
}

-(void)buttonClickEvents:(UIButton *)button{
    self.statusBlock(button.tag);
}

@end

@implementation S_OnWayView

-(instancetype)initWithFrame:(CGRect)frame DataSource:(StatusModel *)dic{
    if (self = [super initWithFrame:frame]) {
        _statusModel = dic;
//        UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-350*PROPORTION750-64, 690*PROPORTION750, 330*PROPORTION750)];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15*PROPORTION750;
        
        MyStar *starView = [[MyStar alloc] initWithFrame:CGRectMake(182.5*PROPORTION750, 160*PROPORTION750, 325*PROPORTION750, 45*PROPORTION750) space:20*PROPORTION750];
        [starView setScore:(CGFloat)[_statusModel.score doubleValue]];
        [self addSubview:starView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 230*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
        UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, line.bottom+30*PROPORTION750, 690*PROPORTION750, 40*PROPORTION750)];
        [shareBtn setImage:[[UIImage imageNamed:@"share_icon"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
        [shareBtn setTitle:@" 分享获得优惠券" forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        shareBtn.titleLabel.font = SYSF750(30);
        //            shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 130*PROPORTION750);
        //            shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [shareBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];
    }
    return self;
}

-(void)buttonClickEvents:(UIButton *)button{
    self.statusBlock();
}

@end



@interface S_EndView()<UITextViewDelegate>
{
    UILabel *tvTipLB;
}

@property (nonatomic, strong) MyStar *starView1;

@property (nonatomic, strong) MyStar *starView2;

@property (nonatomic, strong) MyStar *starView3;

@property (nonatomic, strong) MyStar *starView4;

@property (nonatomic, strong) UITextView *pjTextView;

@end

@implementation S_EndView

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSDictionary *)dic{
    if (self = [super initWithFrame:frame]) {
//        UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-945*PROPORTION750-64, 690*PROPORTION750, 925*PROPORTION750)];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15*PROPORTION750;
        
        UIButton *tsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 160*PROPORTION750, 690*PROPORTION750, 40*PROPORTION750)];
        tsBtn.tag = 100;
        [tsBtn setImage:[[UIImage imageNamed:@"comIcon"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
        [tsBtn setTitle:@" 我要投诉" forState:UIControlStateNormal];
        [tsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tsBtn.titleLabel.font = SYSF750(30);
        //            shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 130*PROPORTION750);
        //            shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [tsBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tsBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 230*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
        UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 230*PROPORTION750, self.width, 70*PROPORTION750)];
        tipLB.text = @"评价";
        tipLB.font = SYSF750(30);
        tipLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipLB];
        
        UILabel *tip1 = [[UILabel alloc] initWithFrame:CGRectMake(90*PROPORTION750, tipLB.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
        tip1.text = @"服务态度";
        tip1.font = SYSF750(30);
        tip1.textAlignment = NSTextAlignmentLeft;
        [self addSubview:tip1];
        [tip1 sizeToFit];
        CGFloat starViewSpace = (470*PROPORTION750-tip1.width)/5-40*PROPORTION750;
        CGFloat starViewWidth = 470*PROPORTION750-tip1.width + starViewSpace;
        
        _starView1 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tipLB.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
        [_starView1 setScore:5.0];
        _starView1.isCanTap = true;
        [self addSubview:_starView1];
        
        UILabel *tip2 = [[UILabel alloc] initWithFrame:CGRectMake(90*PROPORTION750, tip1.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
        tip2.text = @"车辆整洁";
        tip2.font = SYSF750(30);
        tip2.textAlignment = NSTextAlignmentLeft;
        [self addSubview:tip2];
        [tip1 sizeToFit];
        
        _starView2 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tip1.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
        _starView2.isCanTap = true;
        [_starView2 setScore:5.0];
        [self addSubview:_starView2];
        
        UILabel *tip3 = [[UILabel alloc] initWithFrame:CGRectMake(90*PROPORTION750, tip2.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
        tip3.text = @"驾驶技术";
        tip3.font = SYSF750(30);
        tip3.textAlignment = NSTextAlignmentLeft;
        [self addSubview:tip3];
        [tip1 sizeToFit];
        
        _starView3 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tip2.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
        _starView3.isCanTap = true;
        [_starView3 setScore:5.0];
        [self addSubview:_starView3];
        
        UILabel *tip4 = [[UILabel alloc] initWithFrame:CGRectMake(80*PROPORTION750, tip3.bottom+30*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
        tip4.text = @"线路熟悉";
        tip4.font = SYSF750(30);
        tip4.textAlignment = NSTextAlignmentLeft;
        [self addSubview:tip4];
        [tip1 sizeToFit];
        
        _starView4 = [[MyStar alloc] initWithFrame:CGRectMake(tip1.right+40*PROPORTION750, tip3.bottom+25*PROPORTION750, starViewWidth, 40*PROPORTION750) space:starViewSpace];
        _starView4.isCanTap = true;
        [_starView4 setScore:5.0];
        [self addSubview:_starView4];
        
        _pjTextView = [[UITextView alloc] initWithFrame:CGRectMake(90*PROPORTION750, tip4.bottom+30*PROPORTION750, 530*PROPORTION750, 80*PROPORTION750)];
        _pjTextView.clipsToBounds = true;
        _pjTextView.layer.cornerRadius = 15*PROPORTION750;
        _pjTextView.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
        _pjTextView.layer.borderWidth = 2*PROPORTION750;
        _pjTextView.font = SYSF750(25);
        _pjTextView.delegate = self;
        _pjTextView.returnKeyType = UIReturnKeyDone;
        [self addSubview:_pjTextView];
        
        tvTipLB = [[UILabel alloc] initWithFrame:CGRectMake(5*PROPORTION750, 15*PROPORTION750, 500*PROPORTION750, 30*PROPORTION750)];
        tvTipLB.text = @"评价一下此次行程吧，您的的意见很重要！";
        tvTipLB.textColor = [UIColor colorWithHexString:@"999999"];
        tvTipLB.font = SYSF750(25);
        tvTipLB.textAlignment = NSTextAlignmentLeft;
        [_pjTextView addSubview:tvTipLB];
        
        UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(40*PROPORTION750, _pjTextView.bottom+30*PROPORTION750, 610*PROPORTION750, 70*PROPORTION750)];
        upBtn.tag = 200;
        upBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        upBtn.clipsToBounds = YES;
        upBtn.layer.cornerRadius = 15*PROPORTION750;
        [upBtn setTitle:@"提交评价" forState:UIControlStateNormal];
        upBtn.titleLabel.font = SYSF750(35);
        upBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [upBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:upBtn];
        
        //注册键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        //注册键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
//                    UpCommenView *upView = [[UpCommenView alloc] initWithFrame:CGRectMake(0, line2.bottom, 690*PROPORTION750, 760*PROPORTION750)];
//                    [self addSubview:upView];
        
        
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
    if (keyBoardFrame.origin.y < _pjTextView.bottom+AL_DEVICE_HEIGHT-845*PROPORTION750-64){
        [UIView animateWithDuration:1.0f animations:^{
            self.frame = CGRectMake(30*PROPORTION750, -(-keyBoardFrame.origin.y+_pjTextView.bottom+150*PROPORTION750), 690*PROPORTION750, 825*PROPORTION750);
        }];
    }
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    [UIView animateWithDuration:1.0f animations:^{
        self.frame = CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-845*PROPORTION750-64, 690*PROPORTION750, 825*PROPORTION750);
    }];
    
}



-(void)buttonClickEvents:(UIButton *)button{
    if (button.tag == 100) {
        self.statusBlock();
    }else{
        NSString *score1 = [_starView1 getScore];
        NSString *score2 = [_starView2 getScore];
        NSString *score3 = [_starView3 getScore];
        NSString *score4 = [_starView4 getScore];
        NSString *content = _pjTextView.text;
        
        if (_delegate && [_delegate respondsToSelector:@selector(S_EndView:score1:score2:score3:score4:text:)]) {
            [_delegate S_EndView:self
                          score1:score1
                          score2:score2
                          score3:score3
                          score4:score4
                            text:content];
        }
    }
}


@end


