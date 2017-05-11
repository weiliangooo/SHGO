//
//  RefundView.m
//  SHGO
//
//  Created by 魏亮 on 2017/5/11.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "RefundView.h"
#import "AppDelegate.h"
#import "OrderDetailModel.h"
#import "UIImage+ScalImage.h"

@interface RefundView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *myTableView;

@end

@implementation RefundView

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(125*PROPORTION750,(AL_DEVICE_HEIGHT-400*PROPORTION750)/2, 500*PROPORTION750, 400*PROPORTION750) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.clipsToBounds = true;
        _myTableView.layer.cornerRadius = 15*PROPORTION750;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [de.window addSubview:self];
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        
    }
    return self;
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    [self addSubview:self.myTableView];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH/2-40*PROPORTION750, AL_DEVICE_HEIGHT/2+280*PROPORTION750, 80*PROPORTION750, 80*PROPORTION750)];
    closeBtn.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage imageNamed:@"closeBtn"];
    [closeBtn setImage:[image scaleImageByWidth:100*PROPORTION750] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isCheck) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, 500*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [cell addSubview:line];
        ckModel *cModel = [[ckModel alloc] init];
        cModel = _dataSource[indexPath.row];
        cell.textLabel.text = cModel.name;
        return cell;
    }else{
        RefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            cell = [[RefundCell alloc] init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ckModel *cModel = [[ckModel alloc] init];
        cModel = _dataSource[indexPath.row];
        cell.model = cModel;
        cell.buttonClick = ^(UIButton *button){
            self.dataBlock(cModel, button);
        };
        return cell;
    }
}

-(void)closeBtnClickEvent{
    [self removeFromSuperview];
}

@end

@implementation RefundCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
        _titleLB.font = SYSF750(30);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _refundBtn = [[UIButton alloc] initWithFrame:CGRectMake(370*PROPORTION750, 25*PROPORTION750, 100*PROPORTION750, 40*PROPORTION750)];
        _refundBtn.backgroundColor = [UIColor redColor];
        _refundBtn.clipsToBounds = true;
        _refundBtn.layer.cornerRadius = 10*PROPORTION750;
        [_refundBtn setTitle:@"退款" forState:UIControlStateNormal];
        _refundBtn.titleLabel.font = SYSF750(30);
        [_refundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_refundBtn addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_refundBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 88*PROPORTION750, 500*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:line];
    }
    return self;
}

-(void)setModel:(ckModel *)model{
    _model = model;
    _titleLB.text = _model.name;
    if ([_model.orderStatus integerValue] == 20) {
        _refundBtn.backgroundColor = [UIColor colorWithHexString:@"999999"];
        [_refundBtn setTitle:@"已退款" forState:UIControlStateNormal];
    }else{
        _refundBtn.backgroundColor = [UIColor redColor];
        [_refundBtn setTitle:@"退款" forState:UIControlStateNormal];
    }

}

-(void)buttonClickEvent:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"退款"]) {
        self.buttonClick(button);
    }
    
}

@end



















