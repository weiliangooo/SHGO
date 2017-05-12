//
//  CKSetUpViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSetUpViewController.h"
#import "CKSUTableViewCell.h"
#import "CKSUAcountSecurityViewController.h"
#import "CKShareViewController.h"
#import "HelpViewController.h"
#import "CancleOrderAlertView.h"

@interface CKSetUpViewController ()<UITableViewDelegate, UITableViewDataSource, AlertClassDelegate>
{
    NSArray *titles;
}
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation CKSetUpViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 360*PROPORTION750) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.clipsToBounds = YES;
        _myTableView.layer.cornerRadius = 15*PROPORTION750;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.scrollEnabled = NO;
//        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"设置";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    titles = @[@"分享有礼",@"小马帮助",@"法律条款",@"关于我们"];
 
    [self.view addSubview:self.myTableView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, _myTableView.bottom+60*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(exitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
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
    return 0.05;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKSUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CKSUTableViewCell alloc] init];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.titleLB.text = titles[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 100:
        {
            CKSUAcountSecurityViewController *viewController = [[CKSUAcountSecurityViewController  alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 0:
        {
            CKShareViewController *viewController = [[CKShareViewController  alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:
        {
            HelpViewController *viewController = [[HelpViewController  alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)exitBtnClick:(UIButton *)button
{
    CancleOrderAlertView *alerView = [[CancleOrderAlertView alloc] initWithTipTitle:@"是否需要取消订单" TipImage:nil];
    alerView.delegate =self;
    
}

#pragma --mark AlertClassDelegate
-(void)AlertClassView:(id)alertView clickIndex:(NSInteger)index{
    [alertView removeFromSuperview];
    if (index == 100){
       [self gotoLoginViewController]; 
    }
    NSLog(@"%d",(int)index);
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
