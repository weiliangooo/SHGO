//
//  WalletDetailCell.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletDetailCell.h"

@implementation WalletDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 25*PROPORTION750, 270*PROPORTION750, 30*PROPORTION750)];
        _timeLB.text = @"2017-03-20 13:01:12";
        _timeLB.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLB.textAlignment = NSTextAlignmentCenter;
        _timeLB.font = SYSF750(25);
        [self addSubview:_timeLB];
        
        _typeLB = [[UILabel alloc] initWithFrame:CGRectMake(_timeLB.right, 25*PROPORTION750, 245*PROPORTION750, 30*PROPORTION750)];
        _typeLB.text = @"已使用";
        _typeLB.textColor = [UIColor colorWithHexString:@"999999"];
        _typeLB.textAlignment = NSTextAlignmentCenter;
        _typeLB.font = SYSF750(25);
        [self addSubview:_typeLB];
        
        _moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(_typeLB.right, 25*PROPORTION750, 165*PROPORTION750, 30*PROPORTION750)];
        _moneyLB.text = @"10.00元";
        _moneyLB.textColor = [UIColor colorWithHexString:@"999999"];
        _moneyLB.textAlignment = NSTextAlignmentCenter;
        _moneyLB.font = SYSF750(25);
        [self addSubview:_moneyLB];
    }
    return  self;
}

@end
