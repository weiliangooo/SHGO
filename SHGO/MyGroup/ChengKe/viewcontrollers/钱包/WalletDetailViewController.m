//
//  WalletDetailViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletDetailViewController.h"
#import "WalletDetailHeadView.h"
#import "WalletDetailCell.h"
#import "WalletMoneyModel.h"
#import "MyWebViewController.h"

@interface WalletDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) WalletDetailHeadView *ckWalletHeader;

@property (nonatomic, assign) WalletType walletType;

@property (nonatomic, strong) WalletMoneyModel* dataSource;

@end

@implementation WalletDetailViewController

-(UITableView *)myTableView{
    if (!_myTableView){
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 330*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-64-330*PROPORTION750) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

-(instancetype)initWithType:(WalletType)type dataSource:(id)dataSource{
    if (self = [super init]){
        _walletType = type;
        _dataSource = dataSource;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    NSString *tipString;
    NSString *topString;
    NSString *helpString;
    
    if (_walletType == WalletTypeBalance){
        tipString = @"余额（元）";
        topString = @"我的余额";
        helpString = @"常见问题";
    }
    else if (_walletType == WalletTypeRed){
        tipString = @"红包（元）";
        topString = @"我的红包";
        helpString = @"使用规则";
    }
    
    _ckWalletHeader = [[WalletDetailHeadView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 280*PROPORTION750)];
    _ckWalletHeader.titleLB.text = tipString;
    _ckWalletHeader.priceLB.text = ((WalletMoneyModel *)_dataSource).allMoney;
    [_ckWalletHeader.tipBtn setTitle:helpString forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    _ckWalletHeader.buttonBlock = ^(){
        if (_walletType == WalletTypeBalance) {
            MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"常见问题" urlString:@"https://m.xiaomachuxing.com/index/cproblem#balance"];
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        }else{
            MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"使用规则" urlString:@"https://m.xiaomachuxing.com/index/cproblem#packs"];
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        }
        
    };
    [self.view addSubview:_ckWalletHeader];
    
    [self.view addSubview:self.myTableView];
    
    self.topTitle = topString;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.listModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 165*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 165*PROPORTION750)];
    view.backgroundColor = [UIColor whiteColor];
    
    if (((WalletMoneyModel*)_dataSource).listModels.count == 0)
    {
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
        label.text = @"暂无流水";
        label.textColor = [UIColor colorWithHexString:@"999999"];
        label.font = SYSF750(30);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    else
    {
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
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[WalletDetailCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    WalletMoneyListModel *model = ((WalletMoneyModel *)_dataSource).listModels[indexPath.row];
    cell.timeLB.text = model.time;
    cell.typeLB.text = model.type;
    cell.moneyLB.text = model.money;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
