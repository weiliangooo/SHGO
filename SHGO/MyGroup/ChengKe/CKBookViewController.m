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
#import "ActivityModel.h"
#import "CKMsgModel.h"

@interface CKBookViewController ()<BMKMapViewDelegate,CKBookViewDelegate,CKBookMsgViewDelegate,CKPayViewDelegate,DiscoutSelectViewDelegate,BookCKSelectDetailViewDelegate>

///显示界面
@property (nonatomic, strong)CKBookView *bookView;
///选择乘车成员界面
@property (nonatomic, strong)CKBookCKSelectView *ckBookCKSelectView;
///选择优惠界面
@property (nonatomic, strong)CKDiscoutSelectView *ckDiscoutView;
///确认订单界面的model
@property (nonatomic, strong)CKSureOrderModel *sureOrderModel;
///支付界面
@property (nonatomic, strong)CKPayView *payView;
///当前选择的优惠活动
@property (nonatomic, strong)ActivityModel *stActModel;
///选中的乘客
@property (nonatomic, strong)NSMutableArray <CKMsgModel *> *ckModels;
@end

@implementation CKBookViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"确认订单";
    
    NSArray *passengers = [NSArray arrayWithArray:[_inputData arrayForKey:@"passenger"]];
    _ckModels = [NSMutableArray array];
    for (int i = 0 ; i < passengers.count; i++)
    {
        NSDictionary *dic = [passengers objectAtIndex:i];
        CKMsgModel *model = [[CKMsgModel alloc] initWithInputData:dic];
        if ([model.ckOwn integerValue] == 1)
        {
            [_ckModels addObject:model];
            break;
        }
    }
    
    _stActModel = [[ActivityModel alloc] initWithInputData:nil];
    _bookView = [[CKBookView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-880*PROPORTION750-64, AL_DEVICE_WIDTH, 880*PROPORTION750)];
    _bookView.delegate = self;
    _bookView.ckBookMsgView.delegate = self;
    [self.view addSubview:_bookView];
}

#pragma --mark CKBookView 代理
-(void)CKBookViewClickSureBtn
{
    _payView = [[CKPayView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT)];
    _payView.delegate = self;
}

#pragma --mark ckBookMsgView 代理
-(void)CKBookMsgViewEventsWithFlag:(NSInteger)flag
{
    if (flag == 1)
    {
        NSArray *passengers = [NSArray arrayWithArray:[_inputData arrayForKey:@"passenger"]];
        NSMutableArray<CKMsgModel *> *models = [NSMutableArray array];
        for (int i = 0 ; i < passengers.count; i++)
        {
            NSDictionary *dic = [passengers objectAtIndex:i];
            CKMsgModel *model = [[CKMsgModel alloc] initWithInputData:dic];
            [models addObject:model];
            
        }
        _ckBookCKSelectView = [[CKBookCKSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT) allData:models selectData:_ckModels];
        _ckBookCKSelectView.detailView.delegate = self;
    }
    else if (flag == 2)
    {
        NSArray *acts = [NSArray arrayWithArray:[_inputData arrayForKey:@"act"]];
        NSMutableArray<ActivityModel *> *models = [NSMutableArray array];
        for (int i = 0 ; i < acts.count+1; i++)
        {
            ActivityModel *model;
            if (i == acts.count)
            {
                model = [[ActivityModel alloc] initWithInputData:nil];
            }
            else
            {
                NSDictionary *dic = [acts objectAtIndex:i];
                model = [[ActivityModel alloc] initWithInputData:dic];
            }
            [models addObject:model];
        }
        _ckDiscoutView = [[CKDiscoutSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT) data:models];
        _ckDiscoutView.stActModel = _stActModel;
        _ckDiscoutView.delegate = self;
    }
    
}


#pragma --mark CKPayView 代理
-(void)CKPayViwePayBtnClickEvent
{
    [_payView removeFromSuperview];
    CKSendOrderViewController *viewController = [[CKSendOrderViewController alloc] initWithCCMsgModel:self.ccMsgModel];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma --mark CKDiscoutSelectView 代理
-(void)DiscoutSelectView:(CKDiscoutSelectView *)dicoutView selectResult:(ActivityModel *)model
{
    self.stActModel = model;
    [dicoutView removeFromSuperview];
}

#pragma --mark CKDiscoutSelectView 代理
-(void)CKBookCKSelectView:(CKBookCKSelectView *)selectView selectData:(NSMutableArray *)data
{
    self.ckModels = data;
    [selectView removeFromSuperview];
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
