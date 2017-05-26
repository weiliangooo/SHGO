//
//  OrderDetailBaseView.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderDetailBaseView.h"
#import "OrderDetailNoPayview.h"
#import "OrderDetailSystemCancelview.h"
#import "OrederDetailCancleView.h"
#import "OrderDetailRefundView.h"
#import "OrderDetailCarPayView.h"
#import "OrderDetailHadSend.h"
#import "OrderDetailHadPayView.h"
#import "OrderDetailHadCarView.h"
#import "OrderDetailFinishedView.h"
#import "OrderDetailHadCommedView.h"
#import "UIImage+ScalImage.h"
#import "MyStar.h"
#import "OrderDetailModel.h"

@implementation OrderDetailBaseView

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64);
        self.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        
        _scollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64)];
        _scollerView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:_scollerView];
        
        _orderMsgView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 20*PROPORTION750, 710*PROPORTION750, 1000)];
        _orderMsgView.backgroundColor = [UIColor whiteColor];
        _orderMsgView.clipsToBounds = true;
        _orderMsgView.layer.cornerRadius = 15*PROPORTION750;
        [_scollerView addSubview:_orderMsgView];
        
        UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 650*PROPORTION750, 90*PROPORTION750)];
        tipLB.text = @"订单信息";
        tipLB.font = SYSF750(30);
        tipLB.textAlignment = NSTextAlignmentLeft;
        [_orderMsgView addSubview:tipLB];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 90*PROPORTION750, _orderMsgView.width, 2*PROPORTION750)];
        line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [_orderMsgView addSubview:line1];
        
        UILabel *startTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line1.bottom, 325*PROPORTION750, 90*PROPORTION750)];
        startTipLB.text = @"出发地点";
        startTipLB.font = SYSF750(30);
        startTipLB.textAlignment = NSTextAlignmentLeft;
        [_orderMsgView addSubview:startTipLB];
        
        _startLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, line1.bottom, 325*PROPORTION750, 90*PROPORTION750)];
        _startLB.text = @"和地广场北97米";
        _startLB.textColor = [UIColor colorWithHexString:@"999999"];
        _startLB.font = SYSF750(30);
        _startLB.textAlignment = NSTextAlignmentRight;
        [_orderMsgView addSubview:_startLB];
        
        UILabel *endTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, startTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
        endTipLB.text = @"到达地点";
        endTipLB.font = SYSF750(30);
        endTipLB.textAlignment = NSTextAlignmentLeft;
        [_orderMsgView addSubview:endTipLB];
        
        _endLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, startTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
        _endLB.text = @"新都市北97米";
        _endLB.textColor = [UIColor colorWithHexString:@"999999"];
        _endLB.font = SYSF750(30);
        _endLB.textAlignment = NSTextAlignmentRight;
        [_orderMsgView addSubview:_endLB];
        
        UILabel *timeTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, endTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
        timeTipLB.text = @"出发时间";
        timeTipLB.font = SYSF750(30);
        timeTipLB.textAlignment = NSTextAlignmentLeft;
        [_orderMsgView addSubview:timeTipLB];
        
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, endTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
        _timeLB.text = @"2017-05-08 17:45";
        _timeLB.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLB.font = SYSF750(30);
        _timeLB.textAlignment = NSTextAlignmentRight;
        [_orderMsgView addSubview:_timeLB];
        
        UILabel *ckTipLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, timeTipLB.bottom, 325*PROPORTION750, 90*PROPORTION750)];
        ckTipLB.text = @"乘客信息";
        ckTipLB.font = SYSF750(30);
        ckTipLB.textAlignment = NSTextAlignmentLeft;
        [_orderMsgView addSubview:ckTipLB];
        
        _ckLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, timeTipLB.bottom, 300*PROPORTION750, 90*PROPORTION750)];
        _ckLB.text = @"香蕉 苹果 芥子";
        _ckLB.textColor = [UIColor colorWithHexString:@"999999"];
        _ckLB.font = SYSF750(30);
        _ckLB.textAlignment = NSTextAlignmentRight;
        _ckLB.userInteractionEnabled = true;
        [_ckLB addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
        [_orderMsgView addSubview:_ckLB];
        
        UIImageView *rightImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(662*PROPORTION750, timeTipLB.bottom+30*PROPORTION750, 18*PROPORTION750, 30*PROPORTION750)];
        rightImgView1.image = [UIImage imageNamed:@"right_wallet"];
        [_orderMsgView addSubview:rightImgView1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, ckTipLB.bottom, _orderMsgView.width, 2*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [_orderMsgView addSubview:line2];
        
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%.2f元", 192.00]];
        [price addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 1)];
        [price addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(price.length-1, 1)];
        [price addAttribute:NSFontAttributeName value:SYSF750(50) range:NSMakeRange(1, price.length-2)];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 1)];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(price.length-1, 1)];
        [price addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(1, price.length-2)];
        
        _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line2.bottom+30*PROPORTION750, 280*PROPORTION750, 50*PROPORTION750)];
        _priceLB.textAlignment = NSTextAlignmentLeft;
        _priceLB.attributedText = price;
        [_orderMsgView addSubview:_priceLB];
        
        
        UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(355*PROPORTION750, line2.bottom+40*PROPORTION750, 300*PROPORTION750, 30*PROPORTION750)];
        detailLB.text = @"查看明细";
        detailLB.textColor = [UIColor colorWithHexString:@"999999"];
        detailLB.font = SYSF750(30);
        detailLB.textAlignment = NSTextAlignmentRight;
        detailLB.userInteractionEnabled = true;
        [detailLB addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
        [_orderMsgView addSubview:detailLB];
        
        UIImageView *rightImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(662*PROPORTION750, line2.bottom+40*PROPORTION750, 18*PROPORTION750, 30*PROPORTION750)];
        rightImgView2.image = [UIImage imageNamed:@"right_wallet"];
        [_orderMsgView addSubview:rightImgView2];
        
//        UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(530*PROPORTION750, line2.bottom+42.5*PROPORTION750, 130*PROPORTION750, 25*PROPORTION750)];
//        detailBtn.tag = 102;
//        [detailBtn setTitle:@"查看明细" forState:UIControlStateNormal];
//        [detailBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
//        detailBtn.titleLabel.font = SYSF750(25);
////        [detailBtn setImage:[[UIImage imageNamed:@"right_wallet"] scaleImageByHeight:25*PROPORTION750] forState:UIControlStateNormal];
////        detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 130*PROPORTION750, 0, -130*PROPORTION750);
////        detailBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15*PROPORTION750, 0, 15*PROPORTION750);
//        detailBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//        [detailBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
//        [_orderMsgView addSubview:detailBtn];
        
        _orderMsgView.height = line2.bottom+110*PROPORTION750;
        _driverNameLB = nil;
//        [self driverMsgWithView:_orderMsgView];
        
    }
    return self;
}

-(void)setModel:(OrderDetailModel *)model{
    _model = model;
    _startLB.text = _model.startPlace.address;
    _endLB.text = _model.endPlace.address;
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[_model.startTime integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    _timeLB.text = confromTimespStr;
//    [NSString stringWithFormat:@"%@（下单）", confromTimespStr];
//    _timeLB.text = _model.startTime;
    NSString *ckString = @"";
    for (int i = 0 ; i < model.ckMsgs.count; i++) {
        ckModel *cmodel = _model.ckMsgs[i];
        ckString = [ckString stringByAppendingString:[NSString stringWithFormat:@" %@",cmodel.name]];
    }
//    ckString = [ckString stringByAppendingString:@" >"];
    _ckLB.text = ckString;
    [self setPriceString:_model.orderPrice];
    
    [self setCarMsg];
}

-(void)setPriceString:(NSString *)string{
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%.2f元", [string doubleValue]]];
    [price addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(0, 1)];
    [price addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(price.length-1, 1)];
    [price addAttribute:NSFontAttributeName value:SYSF750(50) range:NSMakeRange(1, price.length-2)];
    [price addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, 1)];
    [price addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(price.length-1, 1)];
    [price addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(1, price.length-2)];
    
    _priceLB.attributedText = price;
}

-(void)setCarMsg{
    ckModel *model = [[ckModel alloc] init];
    model = _model.ckMsgs[0];
    if (_driverNameLB != nil) {
        if (_model.driverName.length > 0) {
             _driverNameLB.text = [NSString stringWithFormat:@"%@师傅" ,[_model.driverName substringWithRange:NSMakeRange(0,1)]];
        }
        [_starView setScore:[_model.driverScore doubleValue]];
        _carNameLB.text = _model.carName;
        _carNumLB.text = _model.carCode;
    }
}



-(void)buttonClickEvents:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(OrderDetailBaseViewClickWithTitle:)]) {
        [_delegate OrderDetailBaseViewClickWithTitle:button.titleLabel.text];
    }
}

-(void)viewTapEvents:(UITapGestureRecognizer *)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(OrderDetailBaseViewClickWithTitle:)]) {
        if (tap.view == _ckLB) {
            [_delegate OrderDetailBaseViewClickWithTitle:@"乘客信息"];
        }else{
            [_delegate OrderDetailBaseViewClickWithTitle:@"查看明细"];
        }

    }
}


+(OrderDetailBaseView *)orderDetailViewWithType:(OrederStatus)type{
    switch (type) {
        case OrederStatusNoPay:
            return [[OrderDetailNoPayview alloc] init];
        case OrederStatusSystemCancle:
            return [[OrderDetailSystemCancelview alloc] init];
        case OrederStatusCancle:
            return [[OrederDetailCancleView alloc] init];
        case OrederStatusRefund:
            return [[OrderDetailRefundView alloc] init];
        case OrederStatusCarPay:
            return [[OrderDetailCarPayView alloc] init];
        case OrederStatusHadPay:
            return [[OrderDetailHadPayView alloc] init];
        case OrederStatusHadSend:
            return [[OrderDetailHadSend alloc] init];
        case OrederStatusHadCar:
            return [[OrderDetailHadCarView alloc] init];
        case OrederStatusFinished:
            return [[OrderDetailFinishedView alloc] init];
        case OrederStatusHadCommed:
            return [[OrderDetailHadCommedView alloc] init];
        default:
            return [[OrderDetailBaseView alloc] init];
            break;
    }
}

@end
