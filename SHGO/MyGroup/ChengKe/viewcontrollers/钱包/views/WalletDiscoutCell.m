//
//  WalletDiscoutCell.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletDiscoutCell.h"
#import "WalletQuanModel.h"

@implementation WalletDiscoutCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 175*PROPORTION750)];
        bgImageView.image = [UIImage imageNamed:@"discout_Bg"];
        [self addSubview:bgImageView];
        
        _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 22.5*PROPORTION750, 200*PROPORTION750, 60*PROPORTION750)];
        _priceLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_priceLB];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(370*PROPORTION750, 32.5*PROPORTION750, 240*PROPORTION750, 40*PROPORTION750)];
        _titleLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_titleLB];
        
        _cityLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 135*PROPORTION750, 400*PROPORTION750, 25*PROPORTION750)];
        _cityLB.font = SYSF750(25);
        _cityLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_cityLB];
        
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(370*PROPORTION750, 135*PROPORTION750, 400*PROPORTION750, 25*PROPORTION750)];
        _timeLB.font = SYSF750(25);
        _timeLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLB];
    }
    return self;
}

-(void)setModel:(WalletQuanListModel *)model
{
    _model = model;
    _priceLB.attributedText = _model.price;
    _titleLB.attributedText = _model.title;
    _cityLB.attributedText = _model.city;
    _timeLB.attributedText = _model.end_time;
}

@end
