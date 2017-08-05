//
//  CKSetUpViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "SetUpViewController.h"
#import "SUTableViewCell.h"
#import "SetPassWordViewController.h"
#import "MyWebViewController.h"
#import "CancleOrderAlertView.h"
#import "PopAleatView.h"

@interface SetUpViewController ()<UITableViewDelegate, UITableViewDataSource, AlertClassDelegate, PopAleatViewDelegate>
{
    NSArray *titles;
}
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation SetUpViewController

-(UITableView *)myTableView{
    if (!_myTableView){
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 540*PROPORTION750) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.clipsToBounds = YES;
        _myTableView.layer.cornerRadius = 15*PROPORTION750;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.scrollEnabled = NO;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"设置";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    titles = @[@"修改密码",@"分享有礼",@"小马帮助",@"法律条款",@"关于我们",@"当前版本"];
 
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[SUTableViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLB.text = titles[indexPath.row];
    if (indexPath.row == titles.count-1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightImgView.hidden = true;
        [cell.detailLB setOrigin:CGPointMake(380*PROPORTION750, 0)];
        NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.detailLB.text = app_Version;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            PopAleatView *aleatView = [[PopAleatView alloc] init];
            [aleatView setButtonStr1:@"通过旧密码方式" Str2:@"通过手机验证码方式"];
            aleatView.delegate = self;
        }
            break;
        case 1:{
            MyWebViewController *viewController = [[MyWebViewController  alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2:{
            MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"小马帮助" urlString:@"https://m.xiaomachuxing.com/index/cproblem"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 3:{
            MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"法律条款" urlString:@"https://m.xiaomachuxing.com/index/use-agreement.html"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 4:{
            MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"关于我们" urlString:@"https://m.xiaomachuxing.com/index/about"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)exitBtnClick:(UIButton *)button{
    CancleOrderAlertView *alerView = [[CancleOrderAlertView alloc] initWithTipTitle:@"是否退出登录" TipImage:nil];
    alerView.delegate =self;
}

#pragma --mark AlertClassDelegate
-(void)AlertClassView:(id)alertView clickIndex:(NSInteger)index{
    [alertView removeFromSuperview];
    if (index == 100){
       [self gotoLoginViewController]; 
    }
}

///选择时通过 密码 还是 验证码方式修改密码
-(void)onClick:(UIButton *)sender setbtn:(UIButton *)btn popAleatView:(id)popAleatView{
    SetPassWordViewController *viewController = [[SetPassWordViewController alloc] init];
    if (sender.tag == 0) {///选择通过验证码 修改密码
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [MyHelperNO getUid], @"uid",
                                       [MyHelperNO getMyToken], @"token", nil];
        [self post:@"user/has_pass" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            if (code == 200){
                viewController.isNormal = true;
                [self.navigationController pushViewController:viewController animated:true];
            }
            else if (code == 300){
                [self toast:@"身份认证已过期"];
                [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
            }
            else if (code == 400){
                viewController.isNormal = false;
                [self.navigationController pushViewController:viewController animated:true];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }else if (sender.tag == 1){///选择通过密码 修改密码
        viewController.isNormal = false;
        [self.navigationController pushViewController:viewController animated:true];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
