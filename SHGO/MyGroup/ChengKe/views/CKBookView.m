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
        
        _ckBookMsgView = [[CKBookMsgView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 690*PROPORTION750, 270*PROPORTION750)];
        __weak typeof(self) weakSelf = self;
        _ckBookMsgView.AddOrMoreBtnBlock = ^(){
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(CKBookViewForMoreBtnClickEventWithCKMsg:)])
            {
                [weakSelf.delegate CKBookViewForMoreBtnClickEventWithCKMsg:[NSMutableArray array]];
            }
        };
        [self addSubview:_ckBookMsgView];
        
        UIButton *bookBT = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, _ckBookMsgView.bottom+10*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 90*PROPORTION750)];
        bookBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        [bookBT setTitle:@"立即预订" forState:UIControlStateNormal];
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

@interface CKBookMsgView()

@property (nonatomic, strong)UILabel *startEndCityLB;

@end

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
    _startEndCityLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 298*PROPORTION750, 30*PROPORTION750)];
    _startEndCityLB.text = @"合肥市——>桐城市";
    _startEndCityLB.textColor = [UIColor colorWithHexString:@"#999999"];
    _startEndCityLB.font = SYSF750(30);
    [self addSubview:_startEndCityLB];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(318*PROPORTION750, 30*PROPORTION750, 2*PROPORTION750, 30*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [self addSubview:line1];
    
    UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(line1.right+75*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
    timeImage.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [self addSubview:timeImage];
    
    UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right, 30*PROPORTION750, 245*PROPORTION750, 30*PROPORTION750)];
    timeLB.text = @"今天（03-21）10:00";
    timeLB.textColor = [UIColor colorWithHexString:@"#999999"];
    timeLB.font = SYSF750(25);
    [self addSubview:timeLB];
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [self addSubview:line2];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90*PROPORTION750, 690*PROPORTION750, 88*PROPORTION750)];
    [self addSubview:scrollView];
    
    UIView *lastView;
    
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
                button = [[CKBookCKSelectBtn alloc] initWithFrame:CGRectMake(30*PROPORTION750+lastView.right, 29*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
            }
            button.nameStr = @"sdfsfadsf";
            [scrollView addSubview:button];
            lastView = button;
        }
        else
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750+lastView.right, 29*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
            [button setTitle:@"+" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:button];
        }
        scrollView.contentSize = CGSizeMake(lastView.right, 88*PROPORTION750);
    }
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 178*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
    line3.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [self addSubview:line3];
    
    UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 180*PROPORTION750, 690*PROPORTION750, 90*PROPORTION750)];
    priceLB.text = @"50元";
    priceLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:priceLB];
    
}

-(void)buttonClickEvent:(UIButton *)button
{
    self.AddOrMoreBtnBlock();
}


@end







