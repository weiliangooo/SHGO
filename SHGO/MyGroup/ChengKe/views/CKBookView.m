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
-(instancetype)initWithFrame:(CGRect)frame inputData:(NSDictionary *)inputData
{
    if (self = [super initWithFrame:frame])
    {
        _inputData = inputData;
        self.backgroundColor = [UIColor clearColor];
        
        _ckBookMsgView = [[CKBookMsgView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 690*PROPORTION750, 750*PROPORTION750) inputData:_inputData];
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
    if (_delegate && [_delegate respondsToSelector:@selector(CKBookViewClickSureBtn)])
    {
        [_delegate CKBookViewClickSureBtn];
    }
}



@end

#import "CKBookCKSelectBtn.h"

@interface CKBookMsgView()<CKBookCKSelectBtnDelegate>

///单价
@property (nonatomic, assign) double singlePrice;
//额外费用单价
@property (nonatomic, assign) double otherPrice;
///钱包余额
@property (nonatomic, assign) double money;
@property (nonatomic, strong) UIView *ckView;

@end

@implementation CKBookMsgView

-(instancetype)initWithFrame:(CGRect)frame inputData:(NSDictionary *)inputData;
{
    if (self = [super initWithFrame:frame])
    {
        _inputData = inputData;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 18*PROPORTION750;
        
        NSDictionary *info = [_inputData objectForKey:@"info"];
        _singlePrice = [[info stringForKey:@"price"] doubleValue];
        _otherPrice = [[_inputData stringForKey:@"dis_price"] doubleValue];
        _money = [[_inputData stringForKey:@"user_wallet"] doubleValue];
        
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
        
        
        
        NSDictionary *info = [_inputData objectForKey:@"info"];
        switch (i) {
            case 0:
            {
                UILabel *startEndLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 298*PROPORTION750, 30*PROPORTION750)];
                startEndLB.text = [NSString stringWithFormat:@"%@——>%@", [info stringForKey:@"start_address_name"], [info stringForKey:@"end_address_name"]];
                startEndLB.textColor = [UIColor colorWithHexString:@"#999999"];
                startEndLB.font = SYSF750(30);
                [view addSubview:startEndLB];
            
                UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(318*PROPORTION750, 30*PROPORTION750, 2*PROPORTION750, 30*PROPORTION750)];
                line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
                [view addSubview:line1];
            
                UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(line1.right+70*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
                timeImage.clipsToBounds = YES;
                timeImage.layer.cornerRadius = 15*PROPORTION750;
                timeImage.image = [UIImage imageNamed:@"time"];
                [view addSubview:timeImage];
            
                // 格式化时间
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[_inputData stringForKey:@"unix"] integerValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
             
                UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right+5*PROPORTION750, 30*PROPORTION750, 245*PROPORTION750, 30*PROPORTION750)];
                timeLB.text = [NSString stringWithFormat:@"%@",confromTimespStr];
                timeLB.textColor = [UIColor colorWithHexString:@"#999999"];
                timeLB.font = SYSF750(25);
                [view addSubview:timeLB];
            }
                break;
            case 1:
            {
                _ckView = view;
                for (int i = 0; i < 2; i++)
                {
                    if (i == 0)
                    {
                        CKBookCKSelectBtn * button = [[CKBookCKSelectBtn alloc] initWithFrame:CGRectMake(30*PROPORTION750, 29*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
                        button.isSelected = YES;
                        button.delegate = self;
                        button.tag = 100+i;
                        [view addSubview:button];
                        NSArray *passengers = [NSArray arrayWithArray:[_inputData arrayForKey:@"passenger"]];
                        for (int i = 0 ; i < passengers.count; i++)
                        {
                            NSDictionary *dic = [passengers objectAtIndex:i];
                            CKMsgModel *model = [[CKMsgModel alloc] initWithInputData:dic];
                            if ([model.ckOwn integerValue] == 1)
                            {
                                button.nameStr = model.ckName;
                                break;
                            }
                        }
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(150*PROPORTION750, 29*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
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
                priceLB.text = [NSString stringWithFormat:@"%.2f元/人", _singlePrice];
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
                priceLB.text = [NSString stringWithFormat:@"%.2f元/人",_otherPrice];
                priceLB.textColor = [UIColor colorWithHexString:@"999999"];
                priceLB.textAlignment = NSTextAlignmentRight;
                priceLB.font = SYSF750(25);
                [view addSubview:priceLB];
            }
                break;
            case 4:
            {
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 1000*PROPORTION750, 30*PROPORTION750)];
                titleLB.text = [NSString stringWithFormat:@"账户余额(%.2f元)最高优惠10元",[[_inputData stringForKey:@"user_wallet"] doubleValue]];
                titleLB.textColor = [UIColor blackColor];
                titleLB.textAlignment = NSTextAlignmentLeft;
                titleLB.font = SYSF750(25);
                [titleLB sizeToFit];
                [view addSubview:titleLB];
                
                _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.width-130*PROPORTION750, 15*PROPORTION750, 150*PROPORTION750, 60*PROPORTION750)];
                [_mySwitch addTarget:self action:@selector(IsUseCKWallet:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:_mySwitch];
            }
                break;
            case 5:
            {
                
                _CKNumLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
                _CKNumLB.textAlignment = NSTextAlignmentLeft;
                _CKNumLB.font = SYSF750(25);
                [view addSubview:_CKNumLB];
                [self setCKNumString:@"共1位乘客"];
                
                _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width-230*PROPORTION750, 30*PROPORTION750, 200*PROPORTION750, 30*PROPORTION750)];
                _priceLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:_priceLB];
                
                
                
                [self setPriceString:[NSString stringWithFormat:@"小计：¥%.2f",_singlePrice+_otherPrice]];
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
                
                _discountLB = [[UILabel alloc] initWithFrame:CGRectMake(self.width-450*PROPORTION750, 30*PROPORTION750, 410*PROPORTION750, 30*PROPORTION750)];
                _discountLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:_discountLB];
                [self setDiscountString:@"不使用优惠"];
                
                _discountLB.userInteractionEnabled = YES;
                [_discountLB addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickDiscoutLB:)]];
            }
                break;
            case 7:
            {
                _amoutLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*PROPORTION750, self.width, 30*PROPORTION750)];
                _amoutLB.textAlignment = NSTextAlignmentCenter;
                [view addSubview:_amoutLB];
                [self setAmoutString:[NSString stringWithFormat:@"合计：¥%.2f",_singlePrice+_otherPrice]];
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
    if (mySwitch.on)
    {
        _useWallet = YES;
    }
    else
    {
        _useWallet = NO;
    }
    [self refreshOther];
}



-(void)setCKNumString:(NSString *)CKNumString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:CKNumString];
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
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:priceString];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 3)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(3, string.length-3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(3, string.length-3)];
    
    _priceLB.attributedText = string;
}

-(void)setDiscountString:(NSString *)discountString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@>",discountString]];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(0, string.length-1)];
    [string addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, string.length-1)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(string.length-1, 1)];
    [string addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(string.length-1, 1)];

    _discountLB.attributedText = string;
}

-(void)setAmoutString:(NSString *)amoutString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:amoutString];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 3)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4d00"] range:NSMakeRange(3, string.length-3)];
    [string addAttribute:NSFontAttributeName value:SYSF750(30) range:NSMakeRange(3, string.length-3)];
    
    _amoutLB.attributedText = string;
}

-(void)ClickDiscoutLB:(UITapGestureRecognizer *)tap
{
    [self backEvents:2];
}

-(void)buttonClickEvent:(UIButton *)button
{
    [self backEvents:1];
}

-(void)backEvents:(NSInteger)flag
{
    if (_delegate && [_delegate respondsToSelector:@selector(CKBookMsgViewEventsWithFlag:)])
    {
        [_delegate CKBookMsgViewEventsWithFlag:flag];
    }
}

-(void)setStCKData:(NSMutableArray *)stCKData
{
    _stCKData = stCKData;
    [_ckView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < _stCKData.count+1; i++)
    {
        if (i < _stCKData.count)
        {
            CKMsgModel *model = _stCKData[i];
            CKBookCKSelectBtn * button = [[CKBookCKSelectBtn alloc] initWithFrame:CGRectMake(30*PROPORTION750+100*PROPORTION750*i, 29*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
            button.nameStr = model.ckName;
            button.isSelected = YES;
            button.delegate = self;
            button.tag = 100+i;
            [_ckView addSubview:button];
        }
        else
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(150*PROPORTION750, 29*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
            [button setTitle:@"+" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            [_ckView addSubview:button];
        }
    }
    [self refreshOther];
}

-(void)setStActModel:(ActivityModel *)stActModel
{
    _stActModel = stActModel;
    NSString *title;
    if ([_stActModel.actType isEqualToString:@"event"] || [_stActModel.actType isEqualToString:@"extra"])
    {
        title = [NSString stringWithFormat:@"%@(每人优惠%@元)",_stActModel.actName,_stActModel.actPrice];
    }
    else if ([_stActModel.actType isEqualToString:@"0"])
    {
        title = [NSString stringWithFormat:@"%@",_stActModel.actName];
    }
    else
    {
        title = [NSString stringWithFormat:@"%@(没单优惠%@元)",_stActModel.actName,_stActModel.actPrice];
    }
    [self setDiscountString:title];
    [self refreshOther];
}

-(void)refreshOther
{
    if (_stActModel == nil || _stCKData== nil)
    {
        return;
    }
    double discountPrice = [_stActModel.actPrice doubleValue];
    if (_useWallet)
    {
        double useMoney;
        if (_money > 10)
        {
            useMoney = 10;
        }
        else
        {
            useMoney = _money;
        }
        if ([_stActModel.actType isEqualToString:@"event"] || [_stActModel.actType isEqualToString:@"extra"])
        {
            
            [self setPriceString:[NSString stringWithFormat:@"小计：¥%.2f",(_singlePrice+_otherPrice)*_stCKData.count-useMoney]];
            [self setAmoutString:[NSString stringWithFormat:@"合计：¥%.2f",(_singlePrice+_otherPrice-discountPrice)*_stCKData.count-useMoney]];
        }
        else
        {
            [self setPriceString:[NSString stringWithFormat:@"小计：¥%.2f",(_singlePrice+_otherPrice)*_stCKData.count-useMoney]];
            [self setAmoutString:[NSString stringWithFormat:@"合计：¥%.2f",(_singlePrice+_otherPrice)*_stCKData.count-discountPrice-useMoney]];
        }

    }
    else
    {
        if ([_stActModel.actType isEqualToString:@"event"] || [_stActModel.actType isEqualToString:@"extra"])
        {
            
            [self setPriceString:[NSString stringWithFormat:@"小计：¥%.2f",(_singlePrice+_otherPrice)*_stCKData.count]];
            [self setAmoutString:[NSString stringWithFormat:@"合计：¥%.2f",(_singlePrice+_otherPrice-discountPrice)*_stCKData.count]];
        }
        else
        {
            [self setPriceString:[NSString stringWithFormat:@"小计：¥%.2f",(_singlePrice+_otherPrice)*_stCKData.count]];
            [self setAmoutString:[NSString stringWithFormat:@"合计：¥%.2f",(_singlePrice+_otherPrice)*_stCKData.count-discountPrice]];
        }

    }
}

-(void)CKBookCKSelectBtn:(CKBookCKSelectBtn *)btn isSelected:(BOOL)isSelected
{
    if (_stCKData.count == 1)
    {
        return;
    }
    [_stCKData removeObjectAtIndex:btn.tag-100];
    btn.isSelected = NO;
}

@end







