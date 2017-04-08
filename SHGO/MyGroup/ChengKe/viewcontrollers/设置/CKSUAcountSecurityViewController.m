//
//  CKSUAcountSecurityViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKSUAcountSecurityViewController.h"
#import "CKSUTableViewCell.h"
#import "CKSUCurrentPhoneViewController.h"

@interface CKSUAcountSecurityViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titles;
}
@property (nonatomic, strong) UITableView *myTableView;


@end

@implementation CKSUAcountSecurityViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 270*PROPORTION750) style:UITableViewStylePlain];
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
    self.topTitle = @"账号与安全";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    titles = @[@"手机号",@"密码设置",@"注销账户"];
    
    [self.view addSubview:self.myTableView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, AL_DEVICE_HEIGHT-110*PROPORTION750-64, 710*PROPORTION750, 90*PROPORTION750)];
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
    
    if (indexPath.row == 0)
    {
        cell.detailLB.text = @"153****1234";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            CKSUCurrentPhoneViewController *viewController = [[CKSUCurrentPhoneViewController  alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)exitBtnClick:(UIButton *)button
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
