//
//  BillTableViewCell.m
//  SHGO
//
//  Created by 魏亮 on 2017/7/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "BillTableViewCell.h"

@interface BillTableViewCell()

@property (nonatomic, strong) UIImageView *selectImg;

@property (nonatomic, strong) UILabel *timeLb;

@property (nonatomic, strong) UILabel *startLb;

@property (nonatomic, strong) UILabel *endLb;

@property (nonatomic, strong) UILabel *priceLb;

@end

@implementation BillTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 80*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        self.selectImg.image = [UIImage imageNamed:@"ckunselected"];
        [self addSubview:self.selectImg];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(140*PROPORTION750, 28*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 15*PROPORTION750;
        imageView.image = [UIImage imageNamed:@"time"];
        [self addSubview:imageView];
        
        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+20*PROPORTION750, 28*PROPORTION750, 370*PROPORTION750, 30*PROPORTION750)];
        _timeLb.text = @"2017-03-21 15:01";
        _timeLb.font = SYSF750(25);
        _timeLb.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLb];
        
        UIView *greenView = [[UIImageView alloc] initWithFrame:CGRectMake(140*PROPORTION750, 85*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        greenView.clipsToBounds = YES;
        greenView.layer.cornerRadius = 15*PROPORTION750;
        greenView.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        [self addSubview:greenView];
        
        _startLb = [[UILabel alloc] initWithFrame:CGRectMake(greenView.right+20*PROPORTION750, greenView.top, 370*PROPORTION750, 30*PROPORTION750)];
        _startLb.text = @"合肥市-财富广场";
        _startLb.font = SYSF750(25);
        _startLb.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_startLb];
        
        UIView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(140*PROPORTION750, 142*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        redView.clipsToBounds = YES;
        redView.layer.cornerRadius = 15*PROPORTION750;
        redView.backgroundColor = [UIColor colorWithHexString:@"#ff4f00"];
        [self addSubview:redView];
        
        _endLb = [[UILabel alloc] initWithFrame:CGRectMake(redView.right+20*PROPORTION750, redView.top, 370*PROPORTION750, 30*PROPORTION750)];
        _endLb.text = @"桐城市-青草镇";
        _endLb.font = SYSF750(25);
        _endLb.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_endLb];
        
        _priceLb = [[UILabel alloc] initWithFrame:CGRectMake(_endLb.right, _startLb.top, 160*PROPORTION750, 30*PROPORTION750)];
        _priceLb.text = @"¥5555.00";
        _priceLb.textColor = [UIColor colorWithHexString:@"#ff5000"];
        _priceLb.font = SYSF750(25);
        _priceLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLb];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 198*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected{
    if (isSelected) {
        self.selectImg.image = [UIImage imageNamed:@"ckselected"];
    }else{
        self.selectImg.image = [UIImage imageNamed:@"ckunselected"];
    }
}

-(void)setModel:(BillModel *)model{
    _model = model;
    self.timeLb.text = [MyHelperTool timeSpToTime:_model.order_time];
    self.startLb.text = [NSString stringWithFormat:@"%@-%@", _model.start_address_name, _model.start_name];
    self.endLb.text = [NSString stringWithFormat:@"%@-%@", _model.end_address_name, _model.arrive_name];
    self.priceLb.text = [NSString stringWithFormat:@"¥%@",_model.money];
}

@end
