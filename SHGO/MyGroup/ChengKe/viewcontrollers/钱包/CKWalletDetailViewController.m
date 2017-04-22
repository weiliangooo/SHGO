//
//  CKWalletDetailViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKWalletDetailViewController.h"
#import "CKWalletDQuestionViewController.h"
#import "WalletMoneyModel.h"

@interface CKWalletDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) CKWalletDetailHeader *ckWalletHeader;

@property (nonatomic, strong) WalletMoneyModel *dataSource;

@end

@implementation CKWalletDetailViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 330*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-64-330*PROPORTION750) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

-(instancetype)initWithData:(WalletMoneyModel *)dataSource
{
    if (self = [super init])
    {
        _dataSource = dataSource;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"我的余额";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    _ckWalletHeader = [[CKWalletDetailHeader alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 280*PROPORTION750)];
    _ckWalletHeader.price = _dataSource.allMoney;
    __weak typeof(self) weakSelf = self;
    _ckWalletHeader.buttonBlock = ^(){
        CKWalletDQuestionViewController *viewController = [[CKWalletDQuestionViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    };
    [self.view addSubview:_ckWalletHeader];
    
    
    [self.view addSubview:self.myTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.listModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 165*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 165*PROPORTION750)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 27.5*PROPORTION750, view.width, 30*PROPORTION750)];
    titleLB.text = @"流水详情";
    titleLB.textColor = [UIColor colorWithHexString:@"999999"];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.font = SYSF750(30);
    [view addSubview:titleLB];
    
    UIView *line= [[UIView alloc] initWithFrame:CGRectMake(0, 83*PROPORTION750, view.width, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line];
    
    UILabel *tipTimeLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, line.bottom+25*PROPORTION750, 270*PROPORTION750, 30*PROPORTION750)];
    tipTimeLB.text = @"时间";
    tipTimeLB.textColor = [UIColor colorWithHexString:@"999999"];
    tipTimeLB.textAlignment = NSTextAlignmentCenter;
    tipTimeLB.font = SYSF750(25);
    [view addSubview:tipTimeLB];
    
    UILabel *tipTypeLB = [[UILabel alloc] initWithFrame:CGRectMake(tipTimeLB.right, line.bottom+25*PROPORTION750, 245*PROPORTION750, 30*PROPORTION750)];
    tipTypeLB.text = @"类型";
    tipTypeLB.textColor = [UIColor colorWithHexString:@"999999"];
    tipTypeLB.textAlignment = NSTextAlignmentCenter;
    tipTypeLB.font = SYSF750(25);
    [view addSubview:tipTypeLB];
    
    UILabel *tipMoneyLB = [[UILabel alloc] initWithFrame:CGRectMake(tipTypeLB.right, line.bottom+25*PROPORTION750, 165*PROPORTION750, 30*PROPORTION750)];
    tipMoneyLB.text = @"费用";
    tipMoneyLB.textColor = [UIColor colorWithHexString:@"999999"];
    tipMoneyLB.textAlignment = NSTextAlignmentCenter;
    tipMoneyLB.font = SYSF750(25);
    [view addSubview:tipMoneyLB];
    
    UIView *line2= [[UIView alloc] initWithFrame:CGRectMake(0, 163*PROPORTION750, view.width, 2*PROPORTION750)];
    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [view addSubview:line2];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 160*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 160*PROPORTION750)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50*PROPORTION750, view.width, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"提现" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(outMoneyEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKWalletListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CKWalletListCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    WalletMoneyListModel *model = _dataSource.listModels[indexPath.row];
    cell.timeLB.text = model.time;
    cell.typeLB.text = model.type;
    cell.moneyLB.text = model.money;
    return cell;
}

-(void)outMoneyEvent:(UIButton *)button
{

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


@interface CKWalletDetailHeader()

@property (nonatomic, strong) UILabel *priceLB;

@end

@implementation CKWalletDetailHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15*PROPORTION750;
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 380*PROPORTION750, 25*PROPORTION750)];
        titleLB.text = @"余额（元）";
        titleLB.textColor = [UIColor colorWithHexString:@"999999"];
        titleLB.textAlignment = NSTextAlignmentLeft;
        titleLB.font = SYSF750(25);
        [self addSubview:titleLB];
        
        UIButton *tipBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-180*PROPORTION750, 27.5*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
        [tipBtn setImage:[UIImage imageNamed:@"regular_wallet"] forState:UIControlStateNormal];
        [tipBtn setTitle:@"常见问题" forState:UIControlStateNormal];
        [tipBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        tipBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        tipBtn.titleLabel.font = SYSF750(25);
        [tipBtn addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tipBtn];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 83*PROPORTION750, self.width, 2*PROPORTION750)];
        line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line1];
        
        _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, line1.bottom+30*PROPORTION750, 380*PROPORTION750, 50*PROPORTION750)];
        _priceLB.text = @"5.00元";
        _priceLB.textColor = [UIColor colorWithHexString:@"#1bac1a"];
        _priceLB.textAlignment = NSTextAlignmentLeft;
        _priceLB.font = SYSF750(50);
        [self addSubview:_priceLB];

        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 193*PROPORTION750, self.width, 2*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line2];
        
        UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, line2.bottom+30*PROPORTION750, 380*PROPORTION750, 25*PROPORTION750)];
        tipLB.text = @"支付车费时优先选择";
        tipLB.textColor = [UIColor colorWithHexString:@"999999"];
        tipLB.textAlignment = NSTextAlignmentLeft;
        tipLB.font = SYSF750(25);
        [self addSubview:tipLB];
        
    }
    return self;
}

-(void)buttonClickEvent:(UIButton *)button
{
    self.buttonBlock();
}

-(void)setPrice:(NSString *)price
{
    _price = price;
    _priceLB.text = [NSString stringWithFormat:@"%@元", _price];
}

@end


@implementation CKWalletListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 25*PROPORTION750, 270*PROPORTION750, 30*PROPORTION750)];
        _timeLB.text = @"2017-03-20 13:01:12";
        _timeLB.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLB.textAlignment = NSTextAlignmentCenter;
        _timeLB.font = SYSF750(25);
        [self addSubview:_timeLB];
        
        _typeLB = [[UILabel alloc] initWithFrame:CGRectMake(_timeLB.right, 25*PROPORTION750, 245*PROPORTION750, 30*PROPORTION750)];
        _typeLB.text = @"已使用";
        _typeLB.textColor = [UIColor colorWithHexString:@"999999"];
        _typeLB.textAlignment = NSTextAlignmentCenter;
        _typeLB.font = SYSF750(25);
        [self addSubview:_typeLB];
        
        _moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(_typeLB.right, 25*PROPORTION750, 165*PROPORTION750, 30*PROPORTION750)];
        _moneyLB.text = @"10.00元";
        _moneyLB.textColor = [UIColor colorWithHexString:@"999999"];
        _moneyLB.textAlignment = NSTextAlignmentCenter;
        _moneyLB.font = SYSF750(25);
        [self addSubview:_moneyLB];
    }
    return  self;
}

@end






