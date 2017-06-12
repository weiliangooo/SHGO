//
//  CKBookView.m
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookView.h"
#import "PingCarSelectView.h"

@interface CKBookView(){
    double sAdd;
    double eAdd;
    int sRess;
    int eRess;
}

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSDictionary *inputData;

@property (nonatomic, strong) PingCarSelectView *leftPingView;
@property (nonatomic, strong) PingCarSelectView *rightPingView;

@property (nonatomic, strong) UISwitch *mySwitch;

@property (nonatomic, strong)UILabel *numPsLB;

///单价
@property (nonatomic, assign) double singlePrice;
//额外费用单价
@property (nonatomic, assign) double otherPrice;
///钱包余额
@property (nonatomic, assign) double money;
///专车价格
@property (nonatomic, assign) double vipMoney;

@end

@implementation CKBookView

-(instancetype)initWithFrame:(CGRect)frame inputData:(NSDictionary *)inputData{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = 
        _inputData = [inputData copy];
        NSDictionary *info = [_inputData objectForKey:@"info"];
        _singlePrice = [[info stringForKey:@"price"] doubleValue];
        _otherPrice = [[_inputData stringForKey:@"dis_price"] doubleValue];
        _money = [[_inputData stringForKey:@"user_wallet"] doubleValue];
        _vipMoney = [[_inputData stringForKey:@"vip"] doubleValue];
        
        sAdd = [[_inputData stringForKey:@"s_added"] doubleValue];
        eAdd = [[_inputData stringForKey:@"e_added"] doubleValue];
        sRess = [[[_inputData objectForKey:@"info"] stringForKey:@"start_address"] intValue];
        eRess = [[[_inputData objectForKey:@"info"] stringForKey:@"end_address"] intValue];
        
        [self initTopView];
        [self initBottomView];
//        [self setStActModel:_stActModel];
    }
    return self;
}

-(void)initTopView{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 0, 690*PROPORTION750, 215*PROPORTION750)];
    _topView.clipsToBounds = true;
    _topView.layer.cornerRadius = 15*PROPORTION750;
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _topView.width, 90*PROPORTION750)];
    [_topView addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, self.width, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line];
    
    NSDictionary *info = [_inputData objectForKey:@"info"];
    
    UILabel *startEndLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 298*PROPORTION750, 30*PROPORTION750)];
    startEndLB.text = [NSString stringWithFormat:@"%@——>%@", [info stringForKey:@"start_address_name"], [info stringForKey:@"end_address_name"]];
    startEndLB.textColor = [UIColor colorWithHexString:@"#999999"];
    startEndLB.font = SYSF750(30);
    [view addSubview:startEndLB];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(318*PROPORTION750, 30*PROPORTION750, 2*PROPORTION750, 30*PROPORTION750)];
    line1.backgroundColor = [UIColor clearColor];
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
    
    __weak typeof(self) weakSelf=self;
    
    _leftPingView = [[PingCarSelectView alloc] initWithFrame:CGRectMake(0, view.bottom, 345*PROPORTION750, 125*PROPORTION750) Title:@"拼车" tip:@"经济环保"];
    _leftPingView.priceStr = [info stringForKey:@"price"];
    _leftPingView.isSelect = true;
    _leftPingView.PingCarSelectBlock = ^(){
        if (weakSelf.leftPingView.isSelect) {
            return;
        }
        weakSelf.leftPingView.isSelect = true;
        weakSelf.rightPingView.isSelect = false;
        [weakSelf initLeftBottom];
        [weakSelf clickEvens:99];
    };
    [_topView addSubview:_leftPingView];
    
    _rightPingView = [[PingCarSelectView alloc] initWithFrame:CGRectMake(345*PROPORTION750, view.bottom, 345*PROPORTION750, 125*PROPORTION750) Title:@"专车" tip:@"快捷舒适"];
    _rightPingView.priceStr = [_inputData stringForKey:@"vip"];
    _rightPingView.isSelect = false;
    _rightPingView.PingCarSelectBlock = ^(){
        if (weakSelf.rightPingView.isSelect) {
            return;
        }
        weakSelf.leftPingView.isSelect = false;
        weakSelf.rightPingView.isSelect = true;
        [weakSelf initRightBottom];
        [weakSelf clickEvens:100];
    };
    [_topView addSubview:_rightPingView];
    
}

-(void)initBottomView{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(30*PROPORTION750, _topView.bottom+20*PROPORTION750, 690*PROPORTION750, 195*PROPORTION750)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.clipsToBounds = true;
    _bottomView.layer.cornerRadius = 15*PROPORTION750;
    [self addSubview:_bottomView];
    
    _isLeft = true;
    
    [self initLeftBottom];
    
    UIButton *bookBT = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, _bottomView.bottom+20*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 90*PROPORTION750)];
    bookBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [bookBT setTitle:@"提交订单" forState:UIControlStateNormal];
    bookBT.titleLabel.font = SYSF750(40);
    bookBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    bookBT.clipsToBounds = YES;
    bookBT.layer.cornerRadius = 15.0f*PROPORTION750;
    bookBT.tag = 101;
    [bookBT addTarget:self action:@selector(buttonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bookBT];
}

-(void)initLeftBottom{
    _useWallet = false;
    [_bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _topView.width, 90*PROPORTION750)];
    [_bottomView addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, self.width, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 344*PROPORTION750, 88*PROPORTION750)];
    leftView.tag = 101;
    leftView.userInteractionEnabled = true;
    [leftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
    [view addSubview:leftView];
    
    _numPsLB = [[UILabel alloc] initWithFrame:CGRectMake(137*PROPORTION750, 30*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
    _numPsLB.text = @"1";
    _numPsLB.font = SYSF750(30);
    _numPsLB.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:_numPsLB];
    
    UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(_numPsLB.left-25*PROPORTION750, 30*PROPORTION750, 25*PROPORTION750, 30*PROPORTION750)];
    leftImg.image = [UIImage imageNamed:@"book_num"];
    [leftView addSubview:leftImg];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(_numPsLB.right, 37.5*PROPORTION750, 25*PROPORTION750, 15*PROPORTION750)];
    rightImg.image = [UIImage imageNamed:@"book_down"];
    [leftView addSubview:rightImg];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(344*PROPORTION750, 20*PROPORTION750, 2*PROPORTION750, 50*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(346*PROPORTION750, 0, 344*PROPORTION750, 88*PROPORTION750)];
    rightView.tag = 102;
    rightView.userInteractionEnabled = true;
    [rightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
    [view addSubview:rightView];
    
    UILabel *dicountLB = [[UILabel alloc] initWithFrame:CGRectMake(137*PROPORTION750, 30*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
    dicountLB.text = @"优惠";
    dicountLB.font = SYSF750(30);
    dicountLB.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:dicountLB];
    
    UIImageView *rImg = [[UIImageView alloc] initWithFrame:CGRectMake(dicountLB.right, 37.5*PROPORTION750, 25*PROPORTION750, 15*PROPORTION750)];
    rImg.image = [UIImage imageNamed:@"book_down"];
    [rightView addSubview:rImg];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line.bottom+37.5*PROPORTION750, 1000*PROPORTION750, 30*PROPORTION750)];
    titleLB.text = [NSString stringWithFormat:@"账户余额(%.2f元)",[[_inputData stringForKey:@"user_wallet"] doubleValue]];
    titleLB.textColor = [UIColor blackColor];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = SYSF750(30);
    [titleLB sizeToFit];
    [_bottomView addSubview:titleLB];

    _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_bottomView.width-130*PROPORTION750, line.bottom+20*PROPORTION750, 150*PROPORTION750, 60*PROPORTION750)];
    [_mySwitch addTarget:self action:@selector(IsUseCKWallet:) forControlEvents:UIControlEventValueChanged];
    [_bottomView addSubview:_mySwitch];
}

-(void)initRightBottom{
    
    [_bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _useWallet = false;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _topView.width, 90*PROPORTION750)];
    [_bottomView addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, self.width, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 344*PROPORTION750, 88*PROPORTION750)];
    [view addSubview:leftView];
    
    UILabel *numLB = [[UILabel alloc] initWithFrame:CGRectMake(100*PROPORTION750, 30*PROPORTION750, 144*PROPORTION750, 30*PROPORTION750)];
    numLB.text = @"最多4人";
    numLB.font = SYSF750(30);
    numLB.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:numLB];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(344*PROPORTION750, 20*PROPORTION750, 2*PROPORTION750, 50*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(346*PROPORTION750, 0, 344*PROPORTION750, 88*PROPORTION750)];
    rightView.tag = 102;
    rightView.userInteractionEnabled = true;
    [rightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
    [view addSubview:rightView];
    
    UILabel *dicountLB = [[UILabel alloc] initWithFrame:CGRectMake(137*PROPORTION750, 30*PROPORTION750, 70*PROPORTION750, 30*PROPORTION750)];
    dicountLB.text = @"优惠";
    dicountLB.font = SYSF750(30);
    dicountLB.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:dicountLB];
    
    UIImageView *rImg = [[UIImageView alloc] initWithFrame:CGRectMake(dicountLB.right, 37.5*PROPORTION750, 25*PROPORTION750, 15*PROPORTION750)];
    rImg.image = [UIImage imageNamed:@"book_down"];
    [rightView addSubview:rImg];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line.bottom+37.5*PROPORTION750, 1000*PROPORTION750, 30*PROPORTION750)];
    titleLB.text = [NSString stringWithFormat:@"账户余额(%.2f元)",[[_inputData stringForKey:@"user_wallet"] doubleValue]];
    titleLB.textColor = [UIColor blackColor];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = SYSF750(30);
    [titleLB sizeToFit];
    [_bottomView addSubview:titleLB];
    
    _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_bottomView.width-130*PROPORTION750, line.bottom+20*PROPORTION750, 150*PROPORTION750, 60*PROPORTION750)];
    [_mySwitch addTarget:self action:@selector(IsUseCKWallet:) forControlEvents:UIControlEventValueChanged];
    [_bottomView addSubview:_mySwitch];
}

-(void)IsUseCKWallet:(UISwitch *)mySwitch{
    if (mySwitch.on){
        _useWallet = YES;
        [self clickEvens:103];
    }
    else{
        _useWallet = NO;
        [self clickEvens:104];
    }
    [self refreshOther];
}

-(void)refreshOther{
    if (_leftPingView.isSelect) {
        _numPsLB.text = [NSString stringWithFormat:@"%d", (int)_numPs];
    }
    double discountPrice = [_stActModel.actPrice doubleValue];
    
    double addPrice = _otherPrice;
    
    double sPrice = 0.00;
    double ePrice = 0.00;
    if (sRess == 1) {
        sPrice = sAdd*_numPs;
    }else{
        sPrice = sAdd*_numPs>60?60.00:sAdd*_numPs;
    }
    
    if (eRess == 1) {
        ePrice = eAdd*_numPs;
    }else{
        ePrice = eAdd*_numPs>60?60.00:eAdd*_numPs;
    }
    
    addPrice = sPrice + ePrice;
    
    if (_useWallet){
        if ([_stActModel.actType isEqualToString:@"event"] || [_stActModel.actType isEqualToString:@"extra"])
        {
            self.leftPingView.priceStr = [NSString stringWithFormat:@"%0.2f",(_singlePrice-discountPrice)*_numPs+addPrice-_money>0?(_singlePrice-discountPrice)*_numPs+addPrice-_money:0.00];
            self.rightPingView.priceStr = [NSString stringWithFormat:@"%.2f",_vipMoney-discountPrice-_money>0?_vipMoney-discountPrice-_money:0.00];
        }
        else{
            self.leftPingView.priceStr = [NSString stringWithFormat:@"%0.2f",_singlePrice*_numPs+addPrice-discountPrice-_money>0?_singlePrice*_numPs+addPrice-discountPrice-_money:0.00];
            self.rightPingView.priceStr = [NSString stringWithFormat:@"%.2f",_vipMoney-discountPrice-_money>0?_vipMoney-discountPrice-_money:0.00];
        }
    }
    else{
        if ([_stActModel.actType isEqualToString:@"event"] || [_stActModel.actType isEqualToString:@"extra"]){
            self.leftPingView.priceStr = [NSString stringWithFormat:@"%0.2f",(_singlePrice-discountPrice)*_numPs+addPrice>0?(_singlePrice-discountPrice)*_numPs+addPrice:0.00];
            self.rightPingView.priceStr = [NSString stringWithFormat:@"%.2f",_vipMoney-discountPrice>0?_vipMoney-discountPrice:0.00];
        }else{
            self.leftPingView.priceStr = [NSString stringWithFormat:@"%0.2f",_singlePrice*_numPs+addPrice-discountPrice>0?_singlePrice*_numPs+addPrice-discountPrice:0.00];
            self.rightPingView.priceStr = [NSString stringWithFormat:@"%.2f",_vipMoney-discountPrice-_money>0?_vipMoney-discountPrice:0.00];
        }
    }
    
    if (_leftPingView.isSelect) {
        _APrice = _leftPingView.priceStr;
    }else{
        _APrice = _rightPingView.priceStr;
    }
}

-(void)setStActModel:(ActivityModel *)stActModel{
    _stActModel = stActModel;
    [self refreshOther];
}

-(void)setNumPs:(NSInteger)numPs{
    _numPs = numPs;
    [self refreshOther];
}

-(void)buttonClickEvent{
    [self clickEvens:105];
}

-(void)viewTapEvents:(UITapGestureRecognizer *)tap{
    [self clickEvens:tap.view.tag];
}

///实现代理
-(void)clickEvens:(NSInteger )tag{
    if (_delegate && [_delegate respondsToSelector:@selector(CKBookView:events:)]) {
        [_delegate CKBookView:self events:tag];
    }
}

@end

