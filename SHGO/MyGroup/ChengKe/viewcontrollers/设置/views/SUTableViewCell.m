//
//  CKSUTableViewCell.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "SUTableViewCell.h"

@implementation SUTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 220*PROPORTION750, 90*PROPORTION750)];
        _titleLB.font = SYSF750(25);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _detailLB = [[UILabel alloc] initWithFrame:CGRectMake(342*PROPORTION750, 0, 300*PROPORTION750, 90*PROPORTION750)];
        _detailLB.font = SYSF750(22);
        _detailLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLB];
        
        _rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(662*PROPORTION750, 30*PROPORTION750, 18*PROPORTION750, 30*PROPORTION750)];
        _rightImgView.clipsToBounds = YES;
        _rightImgView.layer.cornerRadius = 15*PROPORTION750;
        _rightImgView.image = [UIImage imageNamed:@"right_wallet"];
        [self addSubview:_rightImgView];
    }
    return self;
}

@end
