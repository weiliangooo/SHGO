//
//  ChengKeLeftView.m
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKLeftView.h"

@interface CKLeftView ()
{
    NSArray *dataArray;
}


@end

@implementation CKLeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UITableView *)myTableView
{
    if(!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.scrollEnabled = NO;
    }
    return _myTableView;
}


-(instancetype)initWithFrame:(CGRect)frame withViewController:(YHBaseViewController *)viewController
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        dataArray = @[@{@"head":@"left_wallet",@"title":@"钱包"},
                      @{@"head":@"left_order",@"title":@"行程"},
                      @{@"head":@"left_ck",@"title":@"乘客"},
                      @{@"head":@"left_setup",@"title":@"设置"}];
        
        _myTableHead = [[CKLeftHeadView alloc] initWithFrame:CGRectMake(0, 0, self.width, 270*PROPORTION750)];
        _myTableHead.leftHeadBlock = ^(NSInteger flag){
            if (flag == 1)
            {
                self.didSelectedBlock(100);
            }
            else if (flag == 2)
            {
                self.didSelectedBlock(200);
            }
        };
        
        _myTableFoot = [[CKLeftFootView alloc] initWithFrame:CGRectMake(0, self.height-100*PROPORTION750, self.width, 100*PROPORTION750)];
        _myTableFoot.phoneOfKFBlock = ^(NSString *phoneNum)
        {
            [viewController phoneAlertView:phoneNum];
        };
        
        
        self.myTableView.tableHeaderView = _myTableHead;
        
//        self.myTableView.tableFooterView = _myTableFoot;

        [self addSubview:self.myTableView];
        
        [self addSubview:_myTableFoot];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*PROPORTION750;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CKLeftCell alloc] init];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[dataArray objectAtIndex:indexPath.row]];
    
    cell.headImage.image = [UIImage imageNamed:[dic stringForKey:@"head"]];
    
    cell.titleLB.text = [dic stringForKey:@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.didSelectedBlock(indexPath.row);
}

@end


@implementation CKLeftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        _headImage.clipsToBounds = YES;
        _headImage.layer.cornerRadius = 20*PROPORTION750;
        [self addSubview:_headImage];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(_headImage.right+30*PROPORTION750, 35*PROPORTION750, 100*PROPORTION750, 30*PROPORTION750)];
        _titleLB.font = SYSF750(30);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
    }
    return self;
}

@end


@implementation CKLeftHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-2*PROPORTION750, self.width, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(60*PROPORTION750, 100*PROPORTION750, 120*PROPORTION750, 120*PROPORTION750)];
        _headView.clipsToBounds = YES;
        _headView.layer.cornerRadius = 60*PROPORTION750;
        _headView.image = [UIImage imageNamed:@"test001"];
        _headView.userInteractionEnabled = YES;
        [_headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImgTapEvent:)]];
        [self addSubview:_headView];
        
        _phoneLB = [[UILabel alloc] initWithFrame:CGRectMake(_headView.right+100*PROPORTION750, 130*PROPORTION750, 200*PROPORTION750, 20*PROPORTION750)];
        _phoneLB.text = @"130****5678";
        _phoneLB.font = SYSF750(22);
        _phoneLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_phoneLB];
        
        _signBtn = [[UIButton alloc] initWithFrame:CGRectMake(_headView.right+100*PROPORTION750, _phoneLB.bottom+20*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
        [_signBtn setBackgroundColor:[UIColor colorWithHexString:@"#19ae19"]];
        _signBtn.clipsToBounds = YES;
        _signBtn.layer.cornerRadius = 8*PROPORTION750;
        _signBtn.titleLabel.font = SYSF750(22);
        [_signBtn addTarget:self action:@selector(signBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_signBtn setImage:[UIImage imageNamed:@"sign_no"] forState:UIControlStateNormal];
        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         
        [_signBtn setImage:[UIImage imageNamed:@"sign_yes"] forState:UIControlStateSelected];
        [_signBtn setTitle:@"已签到" forState:UIControlStateSelected];
        [_signBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateSelected];
        
        [self addSubview:_signBtn];
    }
    return self;
}

-(void)signBtnClickEvent:(UIButton *)button
{
//    if (!button.selected)
//    {
//        button.selected = YES;
//        _signBtn.backgroundColor = [UIColor colorWithHexString:@"#e9ede9"];
//    }
    self.leftHeadBlock(2);
    
}

-(void)headImgTapEvent:(UITapGestureRecognizer *)tap
{
    self.leftHeadBlock(1);
}

-(void)setUpSignBtnStauts:(BOOL)isSelected
{
    if (isSelected)
    {
        _signBtn.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    else
    {
        [_signBtn setBackgroundColor:[UIColor colorWithHexString:@"#19ae19"]];
    }
}


@end



@implementation CKLeftFootView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dialKFPhone)]];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 20*PROPORTION750;
        imageView.image = [UIImage imageNamed:@"phone"];
        [self addSubview:imageView];
        
        UILabel *phoneLB = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+30*PROPORTION750, 37.5*PROPORTION750, 300*PROPORTION750, 25*PROPORTION750)];
        phoneLB.text = @"400-966-3655";
        phoneLB.textColor = [UIColor blackColor];
        phoneLB.font = SYSF750(25);
        phoneLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:phoneLB];
    }
    return self;
}

-(void)dialKFPhone
{
    self.phoneOfKFBlock(@"400-966-3655");
}

@end




















