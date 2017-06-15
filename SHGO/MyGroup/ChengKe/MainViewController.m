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
{
    ///定时器
    NSTimer * timer;
    ///默认60 倒计时
    int countDownTime;
    dispatch_source_t time;
}
@property (nonatomic, strong) AppDelegate *de;
@property (nonatomic, strong) CKMainViewController *mainVC;
@property (nonatomic, strong) CurrentStatusViewController *statusVC;
///左边的菜单界面
@property (nonatomic, strong)CKLeftView *leftView;
///标示当前是否是主页
@property (nonatomic, assign) BOOL isMain;
@property (nonatomic, strong) StatusModel *statusModel;

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
    
    [self loadData];
    _isMain = true;
}

-(void)loadViewController:(BOOL)isMain{
    if (_isMain == isMain) {
        if (!_isMain) {
            [_statusVC refreshCurUI:_statusModel];
        }else{
            if (_mainVC != nil) {
                [_mainVC removeFromParentViewController];
            }
            UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
            titleView.contentMode = UIViewContentModeScaleAspectFill;
            titleView.frame = CGRectMake(0, 0, 75, 20);
            self.navigationItem.titleView = titleView;
            
            _mainVC = [[CKMainViewController alloc] init];
//            BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:_mainVC];
//            navigationController.navigationBar.hidden = NO;
            [self addChildViewController:_mainVC];
//            _de.window.rootViewController = _mainVC;
            [self.view addSubview:_mainVC.view];
        }
        return;
    }else{
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
            [self stopTimer];
        }else{
            
            _statusVC = [[CurrentStatusViewController alloc] init];
            _statusVC.statusModel = _statusModel;
            [self addChildViewController:_statusVC];
            [self.view addSubview:_statusVC.view];
            [self startTimer];
        }
    }
}

-(void)startTimer{
//    timer = [[NSTimer alloc]init];
//    timer= [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(loadData) userInfo:nil repeats:YES];
//    [timer setFireDate:[NSDate distantPast]];
    
    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建一个定时器
    time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置定时器
    dispatch_source_set_timer(time, DISPATCH_TIME_NOW+5.0*NSEC_PER_SEC, 5.0*NSEC_PER_SEC, 0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
        //设置回调
        dispatch_source_set_event_handler(time, ^{
            
            NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [MyHelperNO getUid], @"uid",
                                           [MyHelperNO getMyToken], @"token",nil];
            [self postInbackground:@"index/get_status" withParam:reqDic success:^(id responseObject) {
                int code = [responseObject intForKey:@"status"];
                NSString *msg = [responseObject stringForKey:@"msg"];
                NSLog(@"%@", responseObject);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (code == 200){
                            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                            NSString *flag = [dic stringForKey:@"flag"];
                            if ([flag isEqualToString:@"0"]) {
                                [self loadViewController:true];
                            }else{
                                _statusModel = [[StatusModel alloc] initWithData:dic];
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
                });
            } failure:^(NSError *error) {
                
            }];
        });
        
    });
    
   
    //由于定时器默认是暂停的所以我们启动一下
    //启动定时器
    dispatch_resume(time);
    
}

-(void)stopTimer{
    if (time) {
        dispatch_cancel(time);
        time = nil;
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
                _statusModel = [[StatusModel alloc] initWithData:dic];
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
