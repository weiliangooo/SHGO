//
//  ResonForCancleViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ResonForCancleViewController.h"


@interface ResonForCancleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titles;
}
@property (nonatomic, strong)UITableView *myTableView;

@end

@implementation ResonForCancleViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 100) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.clipsToBounds = YES;
        _myTableView.layer.cornerRadius = 15*PROPORTION750;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"取消原因";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    titles = @[@"行程有变，暂时不需要用车",@"信息填写错误，需要重新下单",@"赶时间，选择乘坐其他交通工具",@"联系不上司机",@"阿斯顿发撒的方式",@"112双方首发"];
    
    self.myTableView.height = [self calTableViewHeightWithCellMaxNum:5 cellNum:6 cellHeight:85*PROPORTION750 headerHeight:145*PROPORTION750 footHeight:180*PROPORTION750];
    
    NSLog(@"%.2f", _myTableView.height);
    
    [self.view addSubview:self.myTableView];
    
    UIButton *subBT = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, _myTableView.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 90*PROPORTION750)];
    subBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [subBT setTitle:@"提交" forState:UIControlStateNormal];
    subBT.titleLabel.font = SYSF750(40);
    subBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    subBT.clipsToBounds = YES;
    subBT.layer.cornerRadius = 15.0f*PROPORTION750;
    subBT.tag = 101;
//    [subBT addTarget:self action:@selector(bookBTClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subBT];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 145*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 710*PROPORTION750, 145*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *topTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*PROPORTION750, backView.width, 30*PROPORTION750)];
    topTitleLB.text = @"行程已取消，请告诉我们原因";
    topTitleLB.font = SYSF750(30);
    topTitleLB.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:topTitleLB];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, topTitleLB.bottom+30*PROPORTION750, backView.width, 25*PROPORTION750)];
    tipLB.text = @"我们会努力为您提供更好的服务";
    tipLB.textColor = [UIColor colorWithHexString:@"#1aad1a"];
    tipLB.font = SYSF750(25);
    tipLB.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:tipLB];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 143*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backView addSubview:line];
    
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 180*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 710*PROPORTION750, 180*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 630*PROPORTION750, 120*PROPORTION750)];
    textView.clipsToBounds = YES;
    textView.layer.cornerRadius = 15*PROPORTION750;
    textView.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
    textView.layer.borderWidth = 2*PROPORTION750;
    [backView addSubview:textView];
    
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[ResonCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = titles[indexPath.row];
    return cell;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end





@implementation ResonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 500*PROPORTION750, 25*PROPORTION750)];
        _titleLB.font = SYSF750(25);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _checkView = [[UIImageView alloc] initWithFrame:CGRectMake(635*PROPORTION750, 25*PROPORTION750, 35*PROPORTION750, 35*PROPORTION750)];
        _checkView.image = [UIImage imageNamed:@"ckunselected"];
        _checkView.userInteractionEnabled = YES;
        [_checkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)]];
        [self addSubview:_checkView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 83*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
    }
    return self;
}

-(void)tapEvent
{
    if (_isSelected)
    {
        [self setIsSelected:NO];
    }
    else
    {
        [self setIsSelected:YES];
    }
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected)
    {
        _checkView.image = [UIImage imageNamed:@"ckselected"];
    }
    else
    {
        _checkView.image = [UIImage imageNamed:@"ckunselected"];
    }
}

@end





















