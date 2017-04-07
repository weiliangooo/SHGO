//
//  CKBookView.m
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookView.h"

@implementation CKBookView

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
        self.backgroundColor = [UIColor clearColor];
        
        _ckBookMsgView = [[CKBookMsgView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 690*PROPORTION750, 750*PROPORTION750)];
        __weak typeof(self) weakSelf = self;
        _ckBookMsgView.AddOrMoreBtnBlock = ^(NSInteger flag){
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(CKBookViewForMoreBtnClickEventWithCKMsg:flag:)])
            {
                [weakSelf.delegate CKBookViewForMoreBtnClickEventWithCKMsg:[NSMutableArray array] flag:flag];
            }
            
            
        };
        [self addSubview:_ckBookMsgView];
        
        
        UIButton *bookBT = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, _ckBookMsgView.bottom+10*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 90*PROPORTION750)];
        bookBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        [bookBT setTitle:@"提交订单" forState:UIControlStateNormal];
        bookBT.titleLabel.font = SYSF750(40);
        bookBT.titleLabel.textAlignment = NSTextAlignmentCenter;
        bookBT.clipsToBounds = YES;
        bookBT.layer.cornerRadius = 15.0f*PROPORTION750;
        bookBT.tag = 101;
        [bookBT addTarget:self action:@selector(bookBTClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bookBT];
    }
    return self;
}

-(void)bookBTClickEvent:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(CKBookViewBackWithCKMsg:)])
    {
        [_delegate CKBookViewBackWithCKMsg:[NSMutableArray array]];
    }
}



@end

#import "CKBookCKSelectBtn.h"


@implementation CKBookMsgView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 18*PROPORTION750;
        
        [self createView];
    }
    return self;
}

-(void)createView
{
    
    UIView *lastView;
    
    for (int i = 0; i < 8; i++)
    {
        UIView *view;
        if (i == 0)
        {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 90*PROPORTION750)];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, self.width, 2*PROPORTION750)];
            line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            [view addSubview:line];
        }
        else if (i == 3)
        {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, lastView.bottom, self.width, 120*PROPORTION750)];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 118*PROPORTION750, self.width, 2*PROPORTION750)];
            line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            [view addSubview:line];
        }
        else
        {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, lastView.bottom, self.width, 90*PROPORTION750)];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, self.width, 2*PROPORTION750)];
            line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            [view addSubview:line];
        }
        
        
        
        
        switch (i) {
            case 0:
            {
                UILabel *startEndLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 298*PROPORTION750, 30*PROPORTION750)];
                startEndLB.text = [NSString stringWithFormat:@"%@——>%@", _model.startCity, _model.endCity];
                startEndLB.textColor = [UIColor colorWithHexString:@"#999999"];
                startEndLB.font = SYSF750(30);
                [view addSubview:startEndLB];
            
                UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(318*PROPORTION750, 30*PROPORTION750, 2*PROPORTION750, 30*PROPORTION750)];
                line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
                [view addSubview:line1];
            
                UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(line1.right+75*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
                timeImage.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
                [view addSubview:timeImage];
            
                UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right, 30*PROPORTION750, 245*PROPORTION750, 30*PROPORTION750)];
                timeLB.text = @"今天（03-21）10:00";
                timeLB.textColor = [UIColor colorWithHexString:@"#999999"];
                timeLB.font = SYSF750(25);
                [view addSubview:timeLB];
            }
                break;
            case 1:
            {
                UIView *lateBtn;
            
                for (int i = 0; i < 4; i++)
                {
                    if (i < 3)
                    {
                        CKBookCKSelectBtn *button;
                        if (i == 0)
                        {
                            button = [[CKBookCKSelectBtn alloc] initWithFrame:CGRectMake(30*PROPORTION750, 29*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
            
                        }
                        else
                        {
                            button = [[CKBookCKSelectBtn alloc] initWithFrame:CGRectMake(30*PROPORTION750+lateBtn.right, 29*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
                        }
                        button.nameStr = @"sdfsfadsf";
                        [view addSubview:button];
                        lateBtn = button;
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750+lateBtn.right, 29*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
                        [button setTitle:@"+" forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
                        [view addSubview:button];
                    }
                }
 
            }
                break;
            case 2:
            {
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 100*PROPORTION750, 30*PROPORTION750)];
                titleLB.text = @"基础价";
                titleLB.textColor = [UIColor blackColor];
                titleLB.textAlignment = NSTextAlignmentLeft;
                titleLB.font = SYSF750(25);
                [view addSubview:titleLB];
                
                UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width-180*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
                priceLB.text = @"¥55.00/人";
                priceLB.textColor = [UIColor blackColor];
                priceLB.textAlignment = NSTextAlignmentRight;
                priceLB.font = SYSF750(25);
                [view addSubview:priceLB];
            }
                break;
            case 3:
            {
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 320*PROPORTION750, 30*PROPORTION750)];
                titleLB.text = @"超过免费送达范围费用：";
                titleLB.textColor = [UIColor blackColor];
                titleLB.textAlignment = NSTextAlignmentLeft;
                titleLB.font = SYSF750(25);
                [view addSubview:titleLB];
                
                UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 60*PROPORTION750, 320*PROPORTION750, 30*PROPORTION750)];
                detailLB.text = @"(起步10元+1.5元／公里)";
                detailLB.textColor = [UIColor colorWithHexString:@"999999"];
                detailLB.textAlignment = NSTextAlignmentLeft;
                detailLB.font = SYSF750(25);
                [view addSubview:detailLB];
                
                UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width-180*PROPORTION750, 45*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
                priceLB.text = @"¥55.00";
                priceLB.textColor = [UIColor colorWithHexString:@"999999"];
                priceLB.textAlignment = NSTextAlignmentRight;
                priceLB.font = SYSF750(25);
                [view addSubview:priceLB];
            }
                break;
            case 4:
            {
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
                titleLB.text = @"账户余额";
                titleLB.textColor = [UIColor blackColor];
                titleLB.textAlignment = NSTextAlignmentLeft;
                titleLB.font = SYSF750(25);
                [view addSubview:titleLB];
                
                _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.width-130*PROPORTION750, 15*PROPORTION750, 150*PROPORTION750, 60*PROPORTION750)];
                [_mySwitch addTarget:self action:@selector(IsUseCKWallet:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:_mySwitch];
            }
                break;
            case 5:
            {
                NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"共1位乘客"];
                [string1 addAttribute:NSForegroundColorAttributeName
                                      value:[UIColor blackColor]
                                      range:NSMakeRange(0, 1)];
                [string1 addAttribute:NSForegroundColorAttributeName
                                value:[UIColor blackColor]
                                range:NSMakeRange(string1.length-3, 3)];
                [string1 addAttribute:NSForegroundColorAttributeName
                                value:[UIColor colorWithHexString:@"#ff4d00"]
                                range:NSMakeRange(1, string1.length-4)];
                _CKNumLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
                _CKNumLB.textAlignment = NSTextAlignmentLeft;
                _CKNumLB.font = SYSF750(25);
                _CKNumLB.attributedText = string1;
                [view addSubview:_CKNumLB];
                
                
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"小计：¥55.00"];
                [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
                [string2 addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 3)];
                [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(3, string2.length-3)];
                [string2 addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(3, string2.length-3)];
                
                _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width-230*PROPORTION750, 30*PROPORTION750, 200*PROPORTION750, 30*PROPORTION750)];
                _priceLB.attributedText = string2;
                _priceLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:_priceLB];
            }
                break;
            case 6:
            {
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
                titleLB.text = @"优惠活动";
                titleLB.textColor = [UIColor blackColor];
                titleLB.textAlignment = NSTextAlignmentLeft;
                titleLB.font = SYSF750(25);
                [view addSubview:titleLB];
                
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"线上支付每人优惠¥27.5>"];
                [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(0, string2.length-1)];
                [string2 addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, string2.length-1)];
                [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(string2.length-1, 1)];
                [string2 addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(string2.length-1, 1)];
                
                _discountLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width-360*PROPORTION750, 30*PROPORTION750, 330*PROPORTION750, 30*PROPORTION750)];
                _discountLB.attributedText = string2;
                _discountLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:_discountLB];
                
                _discountLB.userInteractionEnabled = YES;
                [_discountLB addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickDiscoutLB:)]];
            }
                break;
            case 7:
            {
                NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"合计：¥27.50"];
                [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
                [string2 addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 3)];
                [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(3, string2.length-3)];
                [string2 addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(3, string2.length-3)];
                
                _amoutLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*PROPORTION750, self.width, 30*PROPORTION750)];
                _amoutLB.attributedText = string2;
                _amoutLB.textAlignment = NSTextAlignmentCenter;
                [view addSubview:_amoutLB];
                
                
                
            }
                break;
            default:
                break;
        }
        
        
        
        lastView = view;
        
        [self addSubview:view];
        
    }
    
}

-(void)IsUseCKWallet:(UISwitch *)mySwitch
{
    
}

-(void)ClickDiscoutLB:(UITapGestureRecognizer *)tap
{
    self.AddOrMoreBtnBlock(2);
}

-(void)setCKNumString:(NSString *)CKNumString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"共1位乘客"];
    [string addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:NSMakeRange(0, 1)];
    [string addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:NSMakeRange(string.length-3, 3)];
    [string addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorWithHexString:@"#ff4d00"]
                    range:NSMakeRange(1, string.length-4)];
    
    _CKNumLB.attributedText = string;
}


-(void)setPriceString:(NSString *)priceString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"小计：¥55.00"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 3)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(3, string.length-3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(3, string.length-3)];
    
    _priceLB.attributedText = string;
}

-(void)setDiscountString:(NSString *)discountString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"线上支付每人优惠¥27.5>"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(0, string.length-1)];
    [string addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, string.length-1)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(string.length-1, 1)];
    [string addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(string.length-1, 1)];

    _discountLB.attributedText = string;
}

-(void)setAmoutString:(NSString *)amoutString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"合计：¥27.50"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 3)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(3, string.length-3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(3, string.length-3)];
    
    _amoutLB.attributedText = string;
}


-(void)buttonClickEvent:(UIButton *)button
{
    self.AddOrMoreBtnBlock(1);
}


@end







