//
//  CKDiscoutSelectView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKDiscoutSelectView.h"
#import "UIImage+ScalImage.h"
#import "AppDelegate.h"

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

-(instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)data
{
    if (self = [super initWithFrame:frame])
    {
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [de.window addSubview:self];
        
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        _dataArray =  data;
        CGFloat height = [self calTableViewHeightWithCellMaxNum:5 cellNum:_dataArray.count cellHeight:110*PROPORTION750 headerHeight:90*PROPORTION750 footHeight:90*PROPORTION750];
        self.myTableView.frame = CGRectMake(0, self.height-height, self.width, height);
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 90*PROPORTION750)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-120*PROPORTION750, 30*PROPORTION750)];
    titleLB.text = @"优惠活动";
    titleLB.font = SYSF750(30);
    titleLB.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLB];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-2*PROPORTION750, AL_DEVICE_WIDTH, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 90*PROPORTION750)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width/2, 90*PROPORTION750)];
    cancleBtn.tag = 100;
    cancleBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = SYSF750(40);
    [cancleBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancleBtn];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2, 0, self.width/2, 90*PROPORTION750)];
    sureBtn.tag = 101;
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = SYSF750(40);
    [sureBtn addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 90*PROPORTION750;
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
    ActivityModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.titleLB.text = model.actName;
    [cell.titleLB sizeToFit];
    cell.tipLB.frame = CGRectMake(cell.titleLB.right, 42.5*PROPORTION750, 500*PROPORTION750, 25*PROPORTION750);
    if ([model.actType isEqualToString:@"event"] || [model.actType isEqualToString:@"extra"])
    {
        cell.tipLB.text = [NSString stringWithFormat:@"(每人优惠%@元)",model.actPrice];
    }
    else if ([model.actType isEqualToString:@"0"])
    {
        cell.tipLB.text = @"";
    }
    else
    {
        cell.tipLB.text = [NSString stringWithFormat:@"(每单优惠%@元)",model.actPrice];
    }
    [cell sizeToFit];
    if ([model.actName isEqualToString:_stActModel.actName])
    {
        [cell.mySwitch setOn:YES];
    }
    else
    {
        [cell.mySwitch setOn:NO];
    }
    [cell.mySwitch addTarget:self action:@selector(switchClickEvents:) forControlEvents:UIControlEventValueChanged];
    cell.mySwitch.tag = 100+indexPath.row;
    return cell;
}


-(void)switchClickEvents:(UISwitch *)mySwitch
{
    if (!mySwitch.on)
    {
        [mySwitch setOn:YES];
    }
    else
    {
        _stActModel = [_dataArray objectAtIndex:mySwitch.tag-100];
        [self.myTableView reloadData];
    }
}

-(void)buttonClickEvents:(UIButton *)button
{
    [self removeFromSuperview];
    if (button.tag == 101)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(DiscoutSelectView:selectResult:)])
        {
            [_delegate DiscoutSelectView:self selectResult:_stActModel];
        }
    }
}

-(CGFloat)calTableViewHeightWithCellMaxNum:(NSInteger)cellMaxNum
                                   cellNum:(NSInteger)cellNum
                                cellHeight:(CGFloat)cellHeight
                              headerHeight:(CGFloat)headerHeight
                                footHeight:(CGFloat)footHeight

{
    if (cellNum>cellMaxNum)
    {
        return cellMaxNum*cellHeight+headerHeight+footHeight;
    }
    return cellNum*cellHeight+headerHeight+footHeight;
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
        
        _tipLB = [[UILabel alloc] initWithFrame:CGRectMake(_titleLB.right, 42.5*PROPORTION750, 500*PROPORTION750, 25*PROPORTION750)];
        _tipLB.textColor = [UIColor colorWithHexString:@"#ff4f00"];
        _tipLB.font = SYSF750(25);
        _tipLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_tipLB];
        
        _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-160*PROPORTION750, 25*PROPORTION750, 100*PROPORTION750, 60*PROPORTION750)];
        [self addSubview:_mySwitch];
    }
    return self;
}

@end















