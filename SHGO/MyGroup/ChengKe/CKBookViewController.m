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

#import "CKSendOrderViewController.h"

#import "CKOnTheWayViewController.h"

@interface CKBookViewController ()<BMKMapViewDelegate,CKBookViewDelegate>


@property (nonatomic, strong)CKBookCKSelectView *ckBookCKSelectView;

@end

@implementation CKBookViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"确认预定";
    
    CKBookView *view = [[CKBookView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-400*PROPORTION750-64, AL_DEVICE_WIDTH, 400*PROPORTION750)];
    view.delegate = self;
    [self.view addSubview:view];
}

#pragma --mark CKBookView 代理
-(void)CKBookViewForMoreBtnClickEventWithCKMsg:(NSMutableArray *)ckMsg
{
    _ckBookCKSelectView = [[CKBookCKSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    AppDelegate *de = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [de.window addSubview:_ckBookCKSelectView];
}

-(void)CKBookViewBackWithCKMsg:(NSMutableArray *)ckMsg
{
    CKSendOrderViewController *viewController = [[CKSendOrderViewController alloc] initWithCCMsgModel:self.ccMsgModel];
    [self.navigationController pushViewController:viewController animated:YES];

//    CKOnTheWayViewController *viewController = [[CKOnTheWayViewController alloc] initWithCCMsgModel:self.ccMsgModel];
//    [self.navigationController pushViewController:viewController animated:YES];
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
