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
#import "WalletDiscoutCell.h"
#import "WalletMoneyModel.h"
#import "WalletQuanModel.h"
#import "MyWebViewController.h"

@interface WalletDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) WalletDetailHeadView *ckWalletHeader;

@property (nonatomic, assign) WalletType walletType;

@property (nonatomic, strong) id dataSource;

@end

@implementation WalletDetailViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 330*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-64-330*PROPORTION750) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
//        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

-(instancetype)initWithType:(WalletType)type dataSource:(id)dataSource
{
    if (self = [super init])
    {
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
    
    if (_walletType == WalletTypeBalance || _walletType == WalletTypeRed)
    {
        if (_walletType == WalletTypeBalance)
        {
            tipString = @"余额（元）";
            topString = @"我的余额";
            helpString = @"常见问题";
        }
        else if (_walletType == WalletTypeRed)
        {
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
        
        
        
    }
    else
    {
        topString = @"我的优惠券";
        self.myTableView.frame = CGRectMake(40*PROPORTION750, 0, 670*PROPORTION750, AL_DEVICE_HEIGHT-64);
    }
    [self.view addSubview:self.myTableView];
    
    self.topTitle = topString;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_walletType == WalletTypeBalance || _walletType == WalletTypeRed)
    {
        return ((WalletMoneyModel *)_dataSource).listModels.count;
    }
    else
    {
        return ((WalletQuanModel *)_dataSource).listModels.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_walletType == WalletTypeBalance || _walletType == WalletTypeRed)
    {
        return 165*PROPORTION750;
    }
    else
    {
        return 90*PROPORTION750;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    if (_walletType == WalletTypeBalance || _walletType == WalletTypeRed)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 165*PROPORTION750)];
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
    }
    else
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 90*PROPORTION750)];
        view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        
        if (((WalletQuanModel*)_dataSource).listModels.count == 0)
        {
            view.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
            label.text = @"暂无优惠券";
            label.textColor = [UIColor colorWithHexString:@"999999"];
            label.font = SYSF750(30);
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
        else
        {
            UIButton *tipBtn = [[UIButton alloc] initWithFrame:CGRectMake(520*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
            [tipBtn setImage:[UIImage imageNamed:@"regular_wallet"] forState:UIControlStateNormal];
            [tipBtn setTitle:@"使用规则" forState:UIControlStateNormal];
            [tipBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
            tipBtn.titleLabel.textAlignment = NSTextAlignmentRight;
            tipBtn.titleLabel.font = SYSF750(25);
            [tipBtn addTarget:self action:@selector(buttonClickEvent) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:tipBtn];
        }
        
    }
    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_walletType == WalletTypeBalance || _walletType == WalletTypeRed)
    {
        return 80*PROPORTION750;
    }
    else
    {
        return 205*PROPORTION750;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_walletType == WalletTypeBalance || _walletType == WalletTypeRed)
    {
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
    else
    {
        WalletDiscoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[WalletDiscoutCell alloc] init];
        }
        WalletQuanListModel *model = [[WalletQuanListModel alloc] init];
        model = ((WalletQuanModel *)_dataSource).listModels[indexPath.row];
        cell.model = model;
        return cell;
    }
}

-(void)buttonClickEvent{
    MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"使用规则" urlString:@"https://m.xiaomachuxing.com/index/cproblem#coupon"];
    [self.navigationController pushViewController:viewController animated:YES];
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
