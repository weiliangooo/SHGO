//
//  PingCarSelectView.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/5.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "PingCarSelectView.h"

@interface PingCarSelectView()
{
    UILabel *titleLB;
    UILabel *tipLB;
    UILabel *priceLB;
}
@end

@implementation PingCarSelectView

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title tip:(NSString *)tip{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = true;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent:)]];
        
        titleLB = [[UILabel alloc] initWithFrame:CGRectMake(122.5*PROPORTION750, 15*PROPORTION750, 100*PROPORTION750, 35*PROPORTION750)];
        titleLB.text = title;
        titleLB.font = SYSF750(35);
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLB];
        
        tipLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width-125*PROPORTION750, 25*PROPORTION750, 110*PROPORTION750, 25*PROPORTION750)];
        tipLB.text = tip;
        tipLB.font = SYSF750(25);
        tipLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:tipLB];
        
        priceLB = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLB.bottom+30*PROPORTION750, 345*PROPORTION750, 35*PROPORTION750)];
        priceLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:priceLB];
        
    }
    return self;
}

-(void)setPriceStr:(NSString *)priceStr{
    _priceStr = [NSString stringWithFormat:@"%@元", priceStr];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:_priceStr];
//    [string addAttribute:NSFontAttributeName
//                    value:SYSF750(25)
//                    range:NSMakeRange(0, 1)];
    [string addAttribute:NSFontAttributeName
                    value:SYSF750(35)
                    range:NSMakeRange(0, string.length-1)];
    [string addAttribute:NSFontAttributeName
                    value:SYSF750(25)
                    range:NSMakeRange(string.length-1, 1)];
    
    priceLB.attributedText = string;
}

-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (_isSelect) {
        titleLB.textColor = [UIColor whiteColor];
        tipLB.textColor = [UIColor whiteColor];
        priceLB.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    }else{
        titleLB.textColor = [UIColor blackColor];
        tipLB.textColor = [UIColor blackColor];
        priceLB.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
}

-(void)clickEvent:(UITapGestureRecognizer *)tap{
    self.PingCarSelectBlock();
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
