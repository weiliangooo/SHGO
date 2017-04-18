//
//  ChengKeCenterView.m
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKCenterView.h"

@implementation CKCenterView

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
        self.frame = CGRectMake(AL_DEVICE_WIDTH/2-135*PROPORTION750, AL_DEVICE_HEIGHT/2-180*PROPORTION750, 270*PROPORTION750, 180*PROPORTION750);
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270*PROPORTION750, 90*PROPORTION750)];
        _titleLB.layer.cornerRadius = 10.0f;
        _titleLB.clipsToBounds = YES;
        _titleLB.backgroundColor = [UIColor whiteColor];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.text = @"在此处上车";
        [self addSubview:_titleLB];
        
        _locationImage = [[UIImageView alloc] initWithFrame:CGRectMake(110*PROPORTION750, 110*PROPORTION750, 50*PROPORTION750, 70*PROPORTION750)];
        _locationImage.image = [UIImage imageNamed:@"center_location"];
        _locationImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_locationImage];
    }
    return self;
}


@end
