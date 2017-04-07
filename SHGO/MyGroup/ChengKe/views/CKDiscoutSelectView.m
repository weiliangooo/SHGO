//
//  CKDiscoutSelectView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKDiscoutSelectView.h"

@implementation CKDiscoutSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.height-630*PROPORTION750, self.width, 630*PROPORTION750) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        
        _dataArray = @[@"线上支付首单每人优惠¥27.5",
                       @"红包最多可用10元（红包余额¥10）",
                       @"10元优惠券",
                       @"5元优惠券",
                       @"不使用优惠券"];
        [self addSubview:self.myTableView];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CKDiscoutHeadView *View = [[CKDiscoutHeadView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, 90*PROPORTION750)];
    View.backBlock = ^(){
        [self removeFromSuperview];
    };
    return View;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90*PROPORTION750;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKDiscoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CKDiscoutCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLB.text = _dataArray[indexPath.row];
    [cell.mySwitch addTarget:self action:@selector(switchClickEvents:) forControlEvents:UIControlEventValueChanged];
    return cell;
}


-(void)switchClickEvents:(UISwitch *)mySwitch
{
    
}


@end


@implementation CKDiscoutHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 15*PROPORTION750, 30*PROPORTION750)];
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-120*PROPORTION750, 30*PROPORTION750)];
        titleLB.text = @"优惠活动";
        titleLB.font = SYSF750(30);
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLB];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-2*PROPORTION750, AL_DEVICE_WIDTH, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
    }
    return self;
}

-(void)buttonClickEvent:(UIButton *)button
{
    self.backBlock();
}


@end


@implementation CKDiscoutCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 40*PROPORTION750, 500*PROPORTION750, 30*PROPORTION750)];
        _titleLB.font = SYSF750(30);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-160*PROPORTION750, 25*PROPORTION750, 100*PROPORTION750, 60*PROPORTION750)];
        [self addSubview:_mySwitch];
    }
    return self;
}

@end















