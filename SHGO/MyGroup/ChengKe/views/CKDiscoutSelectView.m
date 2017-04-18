//
//  CKDiscoutSelectView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKDiscoutSelectView.h"
#import "UIImage+ScalImage.h"

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
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        _dataArray =  data;
        CGFloat height = [self calTableViewHeightWithCellMaxNum:5 cellNum:_dataArray.count cellHeight:110*PROPORTION750 headerHeight:90*PROPORTION750 footHeight:0];
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
    CKDiscoutHeadView *View = [[CKDiscoutHeadView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, 90*PROPORTION750)];
    __weak typeof(self) weakSelf = self;
    View.backBlock = ^(){
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DiscoutSelectView:selectResult:)])
        {
            [weakSelf.delegate DiscoutSelectView:weakSelf selectResult:weakSelf.stActModel];
        }
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
    ActivityModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.titleLB.text = model.actName;
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


@implementation CKDiscoutHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 20*PROPORTION750, 30*PROPORTION750)];
        [button setImage:[[UIImage imageNamed:@"rowback"] scaleImageByHeight:60*PROPORTION750] forState:UIControlStateNormal];
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















