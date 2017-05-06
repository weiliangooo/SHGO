//
//  ChengKePlaceTimeView.m
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKPlaceTimeView.h"

@interface CKPlaceTimeView()<UITextFieldDelegate>

@end

@implementation CKPlaceTimeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15.0f;
        
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 35*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        imageView1.clipsToBounds = YES;
        imageView1.layer.cornerRadius = 15.f*PROPORTION750;
        imageView1.backgroundColor = [UIColor colorWithHexString:@"#19ac18"];
        [self addSubview:imageView1];
        
        
        _startPlaceTF = [[UITextField alloc] initWithFrame:CGRectMake(90*PROPORTION750, 0*PROPORTION750, self.width-120*PROPORTION750, 99*PROPORTION750)];
        _startPlaceTF.placeholder = @"您要从哪儿出发";
        _startPlaceTF.font = SYSF(12);
        _startPlaceTF.textAlignment = NSTextAlignmentCenter;
        _startPlaceTF.tag = 100;
        _startPlaceTF.delegate = self;
        [self addSubview:_startPlaceTF];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 98*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 1.5*PROPORTION750)];
        line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:line1];
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 135*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        imageView2.clipsToBounds = YES;
        imageView2.layer.cornerRadius = 15.f*PROPORTION750;
        imageView2.backgroundColor = [UIColor colorWithHexString:@"#ff4f00"];
        [self addSubview:imageView2];
        
        _endPlaceTF = [[UITextField alloc] initWithFrame:CGRectMake(90*PROPORTION750, 100*PROPORTION750, self.width-120*PROPORTION750, 99*PROPORTION750)];
        _endPlaceTF.placeholder = @"您要去哪儿";
        _endPlaceTF.font = SYSF(12);
        _endPlaceTF.textAlignment = NSTextAlignmentCenter;
        _endPlaceTF.tag = 200;
        _endPlaceTF.delegate = self;
        [self addSubview:_endPlaceTF];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 198*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 1.5*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:line2];

        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 235*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        imageView3.clipsToBounds = YES;
        imageView3.layer.cornerRadius = 15.f*PROPORTION750;
        imageView3.image = [UIImage imageNamed:@"time_orange"];;
        [self addSubview:imageView3];
        
        _timeTF = [[UITextField alloc] initWithFrame:CGRectMake(90*PROPORTION750, 200*PROPORTION750, self.width-120*PROPORTION750, 99*PROPORTION750)];
        _timeTF.placeholder = @"请选择用车时间";
        _timeTF.font = SYSF(12);
        _timeTF.textAlignment = NSTextAlignmentCenter;
        _timeTF.tag = 300;
        _timeTF.delegate = self;
        [self addSubview:_timeTF];
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 298*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 2*PROPORTION750)];
        line3.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:line3];
        
    }
    return self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(CKPlaceTimeViewClickEvents:)])
    {
        [_delegate CKPlaceTimeViewClickEvents:textField.tag];
    }
    return NO;
}



@end
