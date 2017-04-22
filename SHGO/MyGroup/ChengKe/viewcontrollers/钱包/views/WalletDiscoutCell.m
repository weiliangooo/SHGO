//
//  WalletDiscoutCell.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletDiscoutCell.h"

@implementation WalletDiscoutCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 175*PROPORTION750)];
        bgImageView.image = [UIImage imageNamed:@"discout_Bg"];
        [self addSubview:bgImageView];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 32.5*PROPORTION750, 200*PROPORTION750, 40*PROPORTION750)];
        _titleLB.text = @"优惠券";
        _titleLB.font = SYSF750(40);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(370*PROPORTION750, 22.5*PROPORTION750, 240*PROPORTION750, 60*PROPORTION750)];
        _priceLB.text = @"5.00¥";
        _priceLB.font = SYSF750(60);
        _priceLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_priceLB];
        
        
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 135*PROPORTION750, 400*PROPORTION750, 25*PROPORTION750)];
        _timeLB.text = @"有效期至2017-03-21";
        _timeLB.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLB.font = SYSF750(25);
        _timeLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLB];
    }
    return self;
}


@end
