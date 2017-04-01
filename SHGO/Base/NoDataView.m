//
//  NoDataView.m
//  LightBuy
//
//  Created by Alen on 16/10/18.
//  Copyright © 2016年 Abel. All rights reserved.
//

#import "NoDataView.h"


@implementation NoDataView

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
        
        _imgSize = CGSizeMake(210*PROPORTION, 105*PROPORTION);
        _tipSize = CGSizeMake(AL_DEVICE_WIDTH, 20*PROPORTION);
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((AL_DEVICE_WIDTH-_imgSize.width)/2, 90*PROPORTION, _imgSize.width, _imgSize.height)];
        _imgView.image = [UIImage imageNamed:@"NoOrder"];
        [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((AL_DEVICE_WIDTH-_tipSize.width)/2, _imgView.bottom+50*PROPORTION, _tipSize.width, _tipSize.height)];
        _tipLabel.text = @"您还没有订单";
        _tipLabel.font = SYSF(15);
        _tipLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [_tipLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
        _tipLabel.userInteractionEnabled = YES;
        [self addSubview:_tipLabel];
    }
    return self;
}

-(void)setImgSize:(CGSize)imgSize
{
    _imgSize = imgSize;
    _imgView.frame = CGRectMake((AL_DEVICE_WIDTH-_imgSize.width)/2, 90*PROPORTION, _imgSize.width, _imgSize.height);
    _tipLabel.frame = CGRectMake((AL_DEVICE_WIDTH-_tipSize.width)/2, _imgView.bottom+50*PROPORTION, _tipSize.width, _tipSize.height);
}

-(void)setTipSize:(CGSize)tipSize
{
    _tipSize = tipSize;
    _tipLabel.frame = CGRectMake((AL_DEVICE_WIDTH-_tipSize.width)/2, _imgView.bottom+50*PROPORTION, _tipSize.width, _tipSize.height);
}

-(void)tapView:(UITapGestureRecognizer *)tap
{
    self.refreshBlock();
}


@end
