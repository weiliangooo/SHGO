//
//  CKBookViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookViewController.h"

#import "CKBookView.h"
#import "AppDelegate.h"
#import "CKBookCKSelectView.h"
#import "CKDiscoutSelectView.h"

#import "CKSendOrderViewController.h"

#import "CKOnTheWayViewController.h"

#import "CKSureOrderModel.h"

#import "CKPayView.h"

@interface CKBookViewController ()<BMKMapViewDelegate,CKBookViewDelegate,CKPayViewDelegate>

///选择乘车成员界面
@property (nonatomic, strong)CKBookCKSelectView *ckBookCKSelectView;
///选择优惠界面
@property (nonatomic, strong)CKDiscoutSelectView *ckDiscoutView;
///确认订单界面的model
@property (nonatomic, strong)CKSureOrderModel *sureOrderModel;

@property (nonatomic, strong)CKPayView *payView;
@end

@implementation CKBookViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"确认订单";
    
    CKBookView *view = [[CKBookView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-880*PROPORTION750-64, AL_DEVICE_WIDTH, 880*PROPORTION750)];
    view.delegate = self;
    [self.view addSubview:view];
}

#pragma --mark CKBookView 代理
-(void)CKBookViewForMoreBtnClickEventWithCKMsg:(NSMutableArray *)ckMsg flag:(NSInteger)flag
{
    
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (flag == 1)
    {
        _ckBookCKSelectView = [[CKBookCKSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
        [de.window addSubview:_ckBookCKSelectView];
    }
    else if (flag == 2)
    {
        _ckDiscoutView = [[CKDiscoutSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
        [de.window addSubview:_ckDiscoutView];
    }
    
}

-(void)CKBookViewBackWithCKMsg:(NSMutableArray *)ckMsg
{
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (flag == 1)
//    {
        _payView = [[CKPayView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _payView.delegate = self;
        [de.window addSubview:_payView];
//    }
    
//    CKSendOrderViewController *viewController = [[CKSendOrderViewController alloc] initWithCCMsgModel:self.ccMsgModel];
//    [self.navigationController pushViewController:viewController animated:YES];

//    CKOnTheWayViewController *viewController = [[CKOnTheWayViewController alloc] initWithCCMsgModel:self.ccMsgModel];
//    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma --mark CKPayView 代理
-(void)CKPayViwePayBtnClickEvent
{
//    [self showLoading:@"please waiting"];
    [_payView removeFromSuperview];
    CKSendOrderViewController *viewController = [[CKSendOrderViewController alloc] initWithCCMsgModel:self.ccMsgModel];
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
