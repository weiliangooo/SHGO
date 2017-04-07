//
//  CKBookCKSelectView.m
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookCKSelectView.h"


@interface CKBookCKSelectView ()


@end

@implementation CKBookCKSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeCurrenView)]];
//        [self addSubview:self.myCollectionView];
        
        CKBookCKSelectDetailView *detailView = [[CKBookCKSelectDetailView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-690*PROPORTION750, 690*PROPORTION750, 560*PROPORTION750) withDataArray:[NSMutableArray array]];
        [self addSubview:detailView];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-115*PROPORTION750, detailView.top-75*PROPORTION750, 55*PROPORTION750, 55*PROPORTION750)];
        closeButton.clipsToBounds = YES;
        closeButton.layer.cornerRadius = 27.5*PROPORTION750;
        closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
        closeButton.layer.borderWidth = 2*PROPORTION750;
        [closeButton setTitle:@"X" forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeCurrenView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
    }
    return self;
}

-(void)closeCurrenView
{
    [self removeFromSuperview];
}

@end


@implementation CKBookCKSelectDetailView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSMutableArray *)dataArray
{
    if (self = [super initWithFrame:frame])
    {
        _dataArray = dataArray;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(printHAHA)]];
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15*PROPORTION750;
        
        [self createUI];
    }
    return self;
}

-(void)printHAHA
{
    NSLog(@"HAHA");
}

-(void)createUI
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 690*PROPORTION750, 70*PROPORTION750)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"选择乘客";
    label.font = SYSF750(35);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    for (int i = 0; i < 10; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(172.5*PROPORTION750*(i%4), 70*PROPORTION750+90*PROPORTION750*(i/4), 172.5*PROPORTION750, 89*PROPORTION750)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        CKBookCKSelectBtn *button = [[CKBookCKSelectBtn alloc] initWithFrame:CGRectMake(10*PROPORTION750, 30*PROPORTION750, 135*PROPORTION750, 30*PROPORTION750)];
        button.nameStr = @"东方不败";
        [view addSubview:button];
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-130*PROPORTION750, 690*PROPORTION750, 130*PROPORTION750)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:footerView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(195*PROPORTION750, 30*PROPORTION750, 300*PROPORTION750, 70*PROPORTION750)];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(35);
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [footerView addSubview:button];
}


@end






