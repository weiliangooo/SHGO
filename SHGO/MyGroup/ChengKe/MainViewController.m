//
//  MainViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/14.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "MainViewController.h"
#import "CKMainViewController.h"
#import "BaseNavViewController.h"
#import "AppDelegate.h"
#import "CurrentStatusViewController.h"
#import "CKLeftView.h"
#import "WalletViewController.h"
#import "CKOrderViewController.h"
#import "QuanViewController.h"
#import "SetUpViewController.h"
#import "MsgChangeViewController.h"
#import "SignAlertView.h"
#import "CKMsgListViewController.h"

@interface MainViewController ()<CKLeftViewDelegate>

@property (nonatomic, strong) AppDelegate *de;
@property (nonatomic, strong) CKMainViewController *mainVC;
@property (nonatomic, strong) CurrentStatusViewController *statusVC;
///左边的菜单界面
@property (nonatomic, strong)CKLeftView *leftView;

@property (nonatomic, assign) BOOL isMain;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self put:<#(NSString *)#> withParam:<#(NSMutableDictionary *)#> success:<#^(id responseObject)success#> failure:<#^(NSError *)failure#>
    _de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.type = 2;
    [self.leftBtn setImage:[UIImage imageNamed:@"left_menu"] forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:@"right_msg"] forState:UIControlStateNormal];
    //    self.topTitle = @"小马出行";
//    [self loadData];
    
//    _isMain = true;
    [self loadViewController:false];
}

-(void)loadViewController:(BOOL)isMain{
//    if (_isMain == isMain) {
//        if (!_isMain) {
//            [_statusVC refreshCurUI];
//        }else{
//            _mainVC = [[CKMainViewController alloc] init];
//            BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:_mainVC];
//            navigationController.navigationBar.hidden = NO;
//            _de.window.rootViewController = navigationController;
//        }
//        return;
//    }
    
    _isMain = isMain;
    if (_isMain) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
        titleView.contentMode = UIViewContentModeScaleAspectFill;
        titleView.frame = CGRectMake(0, 0, 75, 20);
        self.navigationItem.titleView = titleView;
        
        _mainVC = [[CKMainViewController alloc] init];
//        BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:_mainVC];
//        navigationController.navigationBar.hidden = true;
        [self addChildViewController:_mainVC];
        [self.view addSubview:_mainVC.view];
    }else{
        _statusVC = [[CurrentStatusViewController alloc] init];
        [self addChildViewController:_statusVC];
        [self.view addSubview:_statusVC.view];
    }
}

-(void)loadData{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [MyHelperNO getUid], @"uid",
                                    [MyHelperNO getMyToken], @"token",nil];
    [self post:@"index/get_status" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSString *msg = [responseObject stringForKey:@"msg"];
        NSLog(@"%@", responseObject);
        if (code == 200){
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
            NSString *flag = [dic stringForKey:@"flag"];
            if ([flag isEqualToString:@"0"]) {
                [self loadViewController:true];
            }else{
                [self loadViewController:false];
            }
        }
        else if (code == 300){
            [self toast:@"身份认证已过期"];
            [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
        }
        else if (code == 400){
            [self toast:msg];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma --mark 重写父类的方法
-(void)leftBtn:(UIButton *)button{
    [self showLeftView];
}

//用来弹出左边菜单栏
-(void)showLeftView{
    if (!_leftView) {
        _leftView = [[CKLeftView alloc] initWithViewController:self];
        _leftView.delegate = self;
    }else{
        [_leftView showView];
    }
}

#pragma --mark CKLeftViewDelegate
-(void)CKLeftView:(CKLeftView *)leftView didSelectFlag:(NSInteger)flag{
    [leftView hiddenViewAtonce];
    switch (flag) {
        case 100:{
            WalletViewController *viewController = [[WalletViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 101:{
            CKOrderViewController *viewController = [[CKOrderViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 102:{
            QuanViewController *viewController = [[QuanViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 103:{
            SetUpViewController *viewController = [[SetUpViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 201:{
            MsgChangeViewController *viewController = [[MsgChangeViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 202:{
            NSMutableDictionary *reqDic= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [MyHelperNO getUid], @"uid",
                                          [MyHelperNO getMyToken], @"token", nil];
            [self post:@"user/sign" withParam:reqDic success:^(id responseObject) {
                int code = [responseObject intForKey:@"status"];
                NSString *msg = [responseObject stringForKey:@"msg"];
                NSLog(@"%@", responseObject);
                if (code == 200)
                {
                    [_leftView.myTableHead setUpSignBtnStauts:true];
                    SignAlertView *alerView = [[SignAlertView alloc] initWithTipTitle:[NSString stringWithFormat:@"获得红包%.2f元", [[responseObject stringForKey:@"data"] doubleValue]]];
                }
                else if (code == 300)
                {
                    [self toast:@"身份认证已过期"];
                    [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
                }
                else if (code == 400)
                {
                    [_leftView.myTableHead setUpSignBtnStauts:true];
                    [self toast:msg];
                }
            } failure:^(NSError *error) {
                
            }];
        }
            break;
        default:
            break;
    }
    
}


-(void)rightBtn:(UIButton *)button{
    CKMsgListViewController *viewController = [[CKMsgListViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
