//
//  ChengKeLeftView.m
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKLeftView.h"
#import "AppDelegate.h"

@interface CKLeftView ()<UIGestureRecognizerDelegate>
{
    NSArray *dataArray;
    
    UIView *leftView;
}

@property (nonatomic, strong) YHBaseViewController *parentViewController;

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) CKLeftFootView *myTableFoot;

@end

@implementation CKLeftView

-(UITableView *)myTableView
{
    if(!_myTableView){
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftView.width, leftView.height) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.scrollEnabled = NO;
    }
    return _myTableView;
}

-(instancetype)initWithViewController:(YHBaseViewController *)viewController
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds])
    {
        _parentViewController = viewController;
        AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        self.userInteractionEnabled = true;
        UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        maskTap.delegate = self;
        [self addGestureRecognizer:maskTap];
        [de.window addSubview:self];
        
        
        leftView = [[UIView alloc] initWithFrame:CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height)];
        leftView.backgroundColor = [UIColor whiteColor];
        [self addSubview:leftView];
        
        dataArray = @[@{@"head":@"left_wallet",@"title":@"钱包"},
                      @{@"head":@"left_order",@"title":@"行程"},
                      @{@"head":@"discount_wallet",@"title":@"优惠"},
                      @{@"head":@"left_setup",@"title":@"设置"}];
        
        _myTableHead = [[CKLeftHeadView alloc] initWithFrame:CGRectMake(0, 0, leftView.width, 270*PROPORTION750)];
        _myTableHead.headView.userInteractionEnabled = true;
        [_myTableHead.headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewTapEvent)]];
        [_myTableHead.signBtn addTarget:self action:@selector(signBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
        
        _myTableFoot = [[CKLeftFootView alloc] initWithFrame:CGRectMake(0, leftView.height-100*PROPORTION750, leftView.width, 100*PROPORTION750)];
        _myTableFoot.userInteractionEnabled = YES;
        [_myTableFoot addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footViewTapEvent)]];
        
        
        self.myTableView.tableHeaderView = _myTableHead;
        
        [leftView addSubview:self.myTableView];
        
        [leftView addSubview:_myTableFoot];
        
        [self showView];
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
    if (_delegate && [_delegate respondsToSelector:@selector(CKLeftView:didSelectFlag:)]) {
        [_delegate CKLeftView:self didSelectFlag:indexPath.row+100];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

-(void)headViewTapEvent{
    if (_delegate && [_delegate respondsToSelector:@selector(CKLeftView:didSelectFlag:)]) {
        [_delegate CKLeftView:self didSelectFlag:201];
    }
}

-(void)signBtnClickEvent{
    if(!_myTableHead.signBtn.selected){
        if (_delegate && [_delegate respondsToSelector:@selector(CKLeftView:didSelectFlag:)]) {
            [_delegate CKLeftView:self didSelectFlag:202];
        }
    }
}

-(void)footViewTapEvent{
    [_parentViewController phoneAlertView:@"400-966-3655"];
}

-(void)showView{
    self.hidden = false;
    [UIView animateWithDuration:0.5f animations:^{
        leftView.frame = CGRectMake(0, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
    } completion:nil];
}

-(void)hiddenView{
    [UIView animateWithDuration:0.5f animations:^{
        leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        self.hidden = true;
    }];
}

-(void)hiddenViewAtonce{
    leftView.frame = CGRectMake(-480*PROPORTION750, 0, 480*PROPORTION750, [UIScreen mainScreen].bounds.size.height);
    self.hidden = true;
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
        [_headView sd_setImageWithURL:[NSURL URLWithString:[MyHelperNO getMyHeadImage]] placeholderImage:[UIImage imageNamed:@"default"]];
        [self addSubview:_headView];
        
        _phoneLB = [[UILabel alloc] initWithFrame:CGRectMake(_headView.right+100*PROPORTION750, 130*PROPORTION750, 200*PROPORTION750, 20*PROPORTION750)];
        _phoneLB.text = [[MyHelperNO getMyMobilePhone] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _phoneLB.font = SYSF750(22);
        _phoneLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_phoneLB];
        
        _signBtn = [[UIButton alloc] initWithFrame:CGRectMake(_headView.right+100*PROPORTION750, _phoneLB.bottom+20*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
        [_signBtn setBackgroundColor:[UIColor colorWithHexString:@"#19ae19"]];
        _signBtn.clipsToBounds = YES;
        _signBtn.layer.cornerRadius = 8*PROPORTION750;
        _signBtn.titleLabel.font = SYSF750(22);
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

-(void)setUpSignBtnStauts:(BOOL)isSelected
{
    [_signBtn setSelected:isSelected];
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

@end




















