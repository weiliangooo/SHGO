//
//  CKBookViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/27.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookViewController.h"

#import "CKBookView.h"
#import "CKBookCKSelectView.h"
#import "CKDiscoutSelectView.h"
#import "CKSendOrderViewController.h"
#import "CKOnTheWayViewController.h"
#import "CKPayView.h"
#import "CKSureOrderModel.h"

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
///获取所有的活动
@property (nonatomic, strong)NSMutableArray <ActivityModel *> *allActModels;
///当前选择的优惠活动
@property (nonatomic, strong)ActivityModel *stActModel;
///获取所有的活动
@property (nonatomic, strong)NSMutableArray <CKMsgModel *> *allCkModels;
///选中的乘客
@property (nonatomic, strong)NSMutableArray <CKMsgModel *> *ckModels;
@end

@implementation CKBookViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"确认订单";
    
    [self getCKsAndActs];
    
    _bookView = [[CKBookView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-880*PROPORTION750-64, AL_DEVICE_WIDTH, 880*PROPORTION750) inputData:_inputData];
    _bookView.delegate = self;
    _bookView.ckBookMsgView.delegate = self;
    _bookView.ckBookMsgView.stCKData = self.ckModels;
    _bookView.ckBookMsgView.stActModel = self.stActModel;
    [self.view addSubview:_bookView];
}

///获取所有活动和乘客 和 设置默认乘客、默认优惠
-(void)getCKsAndActs
{
    NSArray *acts = [NSArray arrayWithArray:[_inputData arrayForKey:@"act"]];
    _allActModels = [NSMutableArray array];
    _stActModel = [[ActivityModel alloc] init];
    for (int i = 0 ; i < acts.count+1; i++)
    {
        ActivityModel *model;
        if (i == acts.count)
        {
            model = [[ActivityModel alloc] initWithInputData:nil];
            _stActModel = model;
        }
        else
        {
            NSDictionary *dic = [acts objectAtIndex:i];
            model = [[ActivityModel alloc] initWithInputData:dic];
        }
        [_allActModels addObject:model];
    }
    
    NSArray *passengers = [NSArray arrayWithArray:[_inputData arrayForKey:@"passenger"]];
    _ckModels = [NSMutableArray array];
    _allCkModels = [NSMutableArray array];
    for (int i = 0 ; i < passengers.count; i++)
    {
        NSDictionary *dic = [passengers objectAtIndex:i];
        CKMsgModel *model = [[CKMsgModel alloc] initWithInputData:dic];
        [_allCkModels addObject:model];
        if ([model.ckOwn integerValue] == 1)
        {
            [_ckModels addObject:model];
        }
    }
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
        _ckBookCKSelectView = [[CKBookCKSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT) allData:_allCkModels selectData:[_ckModels mutableCopy]];
        _ckBookCKSelectView.detailView.delegate = self;
    }
    else if (flag == 2)
    {
        if (_ckDiscoutView) {
            _ckDiscoutView = nil;
        }
        _ckDiscoutView = [[CKDiscoutSelectView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT) data:_allActModels];
        _ckDiscoutView.stActModel = [_stActModel mutableCopy];
        _ckDiscoutView.delegate = self;
    }
    
}


#pragma --mark CKPayView 代理
-(void)CKPayViwePayEventsWithFlag:(NSInteger)flag
{
//    [_payView removeFromSuperview];
//    CKSendOrderViewController *viewController = [[CKSendOrderViewController alloc] initWithCCMsgModel:self.ccMsgModel];
//    [self.navigationController pushViewController:viewController animated:YES];
    [self MySureOrderModel:flag];
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _sureOrderModel.up_message,@"message",
                                   _sureOrderModel.up_act_id,@"act_id",
                                   _sureOrderModel.up_type,@"act_type",
                                   _sureOrderModel.up_start_time,@"start_time",
                                   _sureOrderModel.up_banci_id,@"banci_id",
                                   _sureOrderModel.up_start,@"start",
                                   _sureOrderModel.up_start_name,@"start_name",
                                   _sureOrderModel.up_arrive_name,@"arrive_name",
                                   _sureOrderModel.up_arriver,@"arriver",
                                   _sureOrderModel.up_paytype,@"paytype",
                                   _sureOrderModel.up_paytool,@"paytool",
                                   _sureOrderModel.up_passenger,@"passenger",
                                   _sureOrderModel.up_use_wallet,@"use_wallet",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"choosecar/order" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSString *msg = [responseObject stringForKey:@"msg"];
        NSLog(@"%@", responseObject);
        if (code == 200)
        {
            
        }
        else if (code == 250)
        {
        
        }
        else if (code == 350)
        {
            
        }
        else if (code == 360)
        {
            
        }
        else if (code == 300)
        {
            [self toast:@"身份认证已过期"];
            [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
        }
        else if (code == 400)
        {
            [self toast:msg];
        }

    } failure:^(NSError *error) {
        
    }];
}

#pragma --mark CKDiscoutSelectView 代理
-(void)DiscoutSelectView:(CKDiscoutSelectView *)dicoutView selectResult:(ActivityModel *)model
{
    _stActModel = model;
    [dicoutView removeFromSuperview];
    _bookView.ckBookMsgView.stActModel = _stActModel;
}

#pragma --mark CKBookCKSelectView 代理
-(void)CKBookCKSelectView:(CKBookCKSelectView *)selectView selectData:(NSMutableArray *)data
{
    _ckModels = data;
    [selectView removeFromSuperview];
    _bookView.ckBookMsgView.stCKData = _ckModels;
}

///生成要提交的model
-(void)MySureOrderModel:(NSInteger)flag
{
    NSDictionary *info = [_inputData objectForKey:@"info"];
    _sureOrderModel = [[CKSureOrderModel alloc] init];
    _sureOrderModel.up_message = @"0";
    _sureOrderModel.up_act_id = _stActModel.actId;
    _sureOrderModel.up_type = _stActModel.actType;
    _sureOrderModel.up_start_time = [_inputData stringForKey:@"unix_zero"];
    _sureOrderModel.up_banci_id = [info stringForKey:@"id"];
    _sureOrderModel.up_start = _startLocal;
    _sureOrderModel.up_start_name = self.ccMsgModel.startPlaceModel.address;
    _sureOrderModel.up_arrive_name = self.ccMsgModel.endPlaceModel.address;
    _sureOrderModel.up_arriver = _endLocal;
    if (flag == 3)
    {
        _sureOrderModel.up_paytype = @"2";
    }
    else
    {
        _sureOrderModel.up_paytype = @"1";
    }
    _sureOrderModel.up_paytool = [NSString stringWithFormat:@"%d", (int)flag];
    
    NSString *passenger = @"";
    for (CKMsgModel *model in _ckModels)
    {
        NSString *stirng = [NSString stringWithFormat:@"%@|%@|%@_",model.ckId,model.ckName,model.ckType];
        passenger = [passenger stringByAppendingString:stirng];
    }
    passenger = [passenger substringToIndex:passenger.length-1];
    _sureOrderModel.up_passenger = passenger;
    _sureOrderModel.up_use_wallet = _bookView.ckBookMsgView.useWallet?@"1":@"2";
    if (([_stActModel.actType isEqualToString:@"event"] || [_stActModel.actType isEqualToString:@"extra"]) && ![_stActModel.actId isEqualToString:_sureOrderModel.up_paytype])
    {
        [self toast:@"线上优惠仅限线上付款"];
        return;
    }
    
    if (([_stActModel.actType isEqualToString:@"user_money"] || [_stActModel.actType isEqualToString:@"coupon"]) && ![_sureOrderModel.up_paytype isEqualToString:@"1"])
    {
        [self toast:@"线上优惠仅限线上付款"];
        return;
    }
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
