//
//  CKLoginTextField.m
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKLoginTextField.h"

@implementation CKLoginTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame leftImgName:(NSString *)leftImgName placeholderTitle:(NSString *)placeholderTitle
{
    if (self = [super initWithFrame:frame])
    {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15.0f*PROPORTION750;
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 25*PROPORTION750, 30*PROPORTION750, 40*PROPORTION750)];
        leftImgView.image = [UIImage imageNamed:leftImgName];
//        leftImgView.contentMode = UIViewContentModeCenter;
        [self addSubview:leftImgView];
        
        _myTextField = [[UITextField alloc] initWithFrame:CGRectMake(leftImgView.right+30*PROPORTION750, 30*PROPORTION750, self.width-120*PROPORTION750, 30*PROPORTION750)];
        _myTextField.font = SYSF750(30);
        _myTextField.placeholder = placeholderTitle;
        [self addSubview:_myTextField];
        
    }
    return self;
}

@end
