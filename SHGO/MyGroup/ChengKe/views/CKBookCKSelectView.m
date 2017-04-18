//
//  CKBookCKSelectView.m
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookCKSelectView.h"
#import "UIImage+ScalImage.h"


@interface CKBookCKSelectView ()


@end

@implementation CKBookCKSelectView

-(instancetype)initWithFrame:(CGRect)frame allData:(NSMutableArray *)allCKData selectData:(NSMutableArray *)selectData
{
    if (self = [super initWithFrame:frame])
    {
        _allCKData = allCKData;
        _selectData = selectData;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeCurrenView)]];
//        [self addSubview:self.myCollectionView];
        
        _detailView = [[CKBookCKSelectDetailView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-690*PROPORTION750, 690*PROPORTION750, 560*PROPORTION750) allData:_allCKData selectData:_selectData];
        [self addSubview:_detailView];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-115*PROPORTION750, _detailView.top-75*PROPORTION750, 55*PROPORTION750, 55*PROPORTION750)];
        closeButton.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"closeBtn"];
        [closeButton setImage:[image scaleImageByWidth:100*PROPORTION750] forState:UIControlStateNormal];
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

-(instancetype)initWithFrame:(CGRect)frame allData:(NSMutableArray *)allCKData selectData:(NSMutableArray *)selectData
{
    if (self = [super initWithFrame:frame])
    {
        _allCKData = allCKData;
        _selectData = selectData;
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
    
    for (int i = 0; i < _allCKData.count; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(172.5*PROPORTION750*(i%4), 70*PROPORTION750+90*PROPORTION750*(i/4), 172.5*PROPORTION750, 89*PROPORTION750)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        CKMsgModel *model = _allCKData[i];
        CKBookCKSelectBtn *button = [[CKBookCKSelectBtn alloc] initWithFrame:CGRectMake(10*PROPORTION750, 30*PROPORTION750, 135*PROPORTION750, 30*PROPORTION750)];
        button.delegate = self;
        button.tag = 100+i;
        button.nameStr = model.ckName;
        button.isSelected = [self ckIsSelected:model];
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
    [button addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
}

-(BOOL)ckIsSelected:(CKMsgModel *)aModel
{
    for (int i = 0; i < _selectData.count; i++)
    {
        CKMsgModel *model = _selectData[i];
        if ([model.ckId isEqualToString:aModel.ckId])
        {
            return YES;
        }
    }
    return NO;
}



-(void)sureBtnClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(CKBookCKSelectView:selectData:)])
    {
        [_delegate CKBookCKSelectView:(CKBookCKSelectView *)self.superview selectData:_selectData];
    }
}

-(void)CKBookCKSelectBtn:(CKBookCKSelectBtn *)btn isSelected:(BOOL)isSelected
{
    if (isSelected)
    {
        [_selectData addObject:_allCKData[btn.tag-100]];
    }
    else
    {
        for (int i = 0; i < _selectData.count; i++)
        {
            CKMsgModel *model = _selectData[i];
            if ([model.ckId isEqualToString:_allCKData[btn.tag-100].ckId])
            {
                [_selectData removeObjectAtIndex:i];
                break;
            }
        }

    }
}

@end






