//
//  OrderDetailView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderDetailView.h"
#import "OrderDetailModel.h"
#import "MyStar.h"
#import "UIImage+ScalImage.h"

@implementation OrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame dataSourece:(OrderDetailModel *)dataSource
{
    if (self = [super initWithFrame:frame])
    {
        _orderDetailModel = dataSource;
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15*PROPORTION750;
        
        UILabel *driverLB = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, 20*PROPORTION750, 130*PROPORTION750, 40*PROPORTION750)];
        driverLB.text = _orderDetailModel.driverName;
        driverLB.font = SYSF750(30);
        driverLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:driverLB];
        
        UIImageView *phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(driverLB.right, 20*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        phoneImgView.tag = 101;
        phoneImgView.image = [UIImage imageNamed:@"phone"];
        phoneImgView.userInteractionEnabled = YES;
        [phoneImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTagEvents:)]];
        [self addSubview:phoneImgView];
        
        UILabel *carBrandLB = [[UILabel alloc] initWithFrame:CGRectMake(470*PROPORTION750, 20*PROPORTION750, 170*PROPORTION750, 40*PROPORTION750)];
        carBrandLB.text = _orderDetailModel.carName;
        carBrandLB.font = SYSF750(30);
        carBrandLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:carBrandLB];
        

        MyStar *myStar = [[MyStar alloc] initWithFrame:CGRectMake(170*PROPORTION750, 145*PROPORTION750, 350*PROPORTION750, 30*PROPORTION750) space:30*PROPORTION750];
        myStar.isCanTap = NO;
        [myStar setScore:[_orderDetailModel.driverScore doubleValue]];
        [self addSubview:myStar];
        
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 218*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line1];
        
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%@元", _orderDetailModel.orderPrice ]];
        [price addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 1)];
        [price addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(price.length-1, 1)];
        [price addAttribute:NSFontAttributeName value:SYSF750(50) range:NSMakeRange(1, price.length-2)];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 1)];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(price.length-1, 1)];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(1, price.length-2)];

        UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, line1.bottom+30*PROPORTION750, 280*PROPORTION750, 50*PROPORTION750)];
        priceLB.textAlignment = NSTextAlignmentLeft;
        priceLB.attributedText = price;
        [self addSubview:priceLB];
        
        UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(510*PROPORTION750, line1.bottom+42.5*PROPORTION750, 130*PROPORTION750, 25*PROPORTION750)];
        detailBtn.tag = 102;
        [detailBtn setTitle:@"查看明细" forState:UIControlStateNormal];
        [detailBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        detailBtn.titleLabel.font = SYSF750(25);
        [detailBtn setImage:[[UIImage imageNamed:@"right_wallet"] scaleImageByHeight:25*PROPORTION750] forState:UIControlStateNormal];
        detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 115*PROPORTION750, 0, -115*PROPORTION750);
        detailBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15*PROPORTION750, 0, 15*PROPORTION750);
        [detailBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailBtn];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 328*PROPORTION750, 690*PROPORTION750, 2*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line2];
        
        UILabel *ckTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line2.bottom+25*PROPORTION750, 90*PROPORTION750, 25*PROPORTION750)];
        ckTipLB.text = @"乘客：";
        ckTipLB.textColor = [UIColor colorWithHexString:@"999999"];
        ckTipLB.font = SYSF750(25);
        ckTipLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:ckTipLB];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(120*PROPORTION750, line2.bottom+25*PROPORTION750, 520*PROPORTION750, 30*PROPORTION750)];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        UILabel *lastLB;
        
        for (int i = 0 ; i < _orderDetailModel.ckNames.count; i++)
        {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750*i+lastLB.right, 0, 200, 25*PROPORTION750)];
            lable.text = _orderDetailModel.ckNames[i];
            lable.font = SYSF750(25);
            lable.textAlignment = NSTextAlignmentLeft;
            [lable sizeToFit];
            [scrollView addSubview:lable];
            lastLB = lable;
            scrollView.contentSize = CGSizeMake(lastLB.right, 25*PROPORTION750);
        }
        
//        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-75*PROPORTION750, 690*PROPORTION750, 75*PROPORTION750)];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height-75*PROPORTION750, 690*PROPORTION750, 75*PROPORTION750)];
        button.tag = 103;
        [button setTitle:@"分享此次行程获得现金红包" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = SYSF750(25);
        [button setImage:[[UIImage imageNamed:@"share_icon"] scaleImageByHeight:40*PROPORTION750] forState:UIControlStateNormal];
//        button.imageEdgeInsets = UIEdgeInsetsMake(20*PROPORTION750, 0, 20*PROPORTION750, 0);
        [button addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

-(void)viewTagEvents:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(orderDetailView:ClickEvents:inputString:)])
    {
        [_delegate orderDetailView:self ClickEvents:OrderDetailViewEventPhone inputString:@""];
    }
}

-(void)buttonClickEvents:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(orderDetailView:ClickEvents:inputString:)])
    {
        [_delegate orderDetailView:self ClickEvents:button.tag inputString:@""];
    }
}



@end
