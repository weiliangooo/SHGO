//
//  BillHistoryViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/7/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "BillHistoryViewController.h"
#import "BillHistoryTableViewCell.h"
#import "BillHisModel.h"

@interface BillHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) UIView *tipView;

@property (nonatomic, strong) NSMutableArray<BillHisModel *> *billHisModels;

@end

@implementation BillHistoryViewController

-(UIView *)tipView{
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64)];
        _tipView.backgroundColor = [UIColor clearColor];
        UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 340*PROPORTION750, AL_DEVICE_WIDTH, 40*PROPORTION750)];
        tipLb.text = @"你还没有开过发票！";
        tipLb.textAlignment = NSTextAlignmentCenter;
        tipLb.textColor = [UIColor colorWithHexString:@"999999"];
        tipLb.font = SYSF750(35);
        [_tipView addSubview:tipLb];
    }
    return _tipView;
}

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 0, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-64) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[BillHistoryTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    self.topTitle = @"开票历史";
    self.type = 1;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    [self.view addSubview:self.tipView];
    [self.view addSubview:self.myTableView];
    
    [self loadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.billHisModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 85*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 100*PROPORTION750)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    BillHisModel *model = self.billHisModels[section];
    UILabel *monthLb = [[UILabel alloc] initWithFrame:CGRectMake(10*PROPORTION750, 30*PROPORTION750, view.width-20*PROPORTION750, 25*PROPORTION750)];
    monthLb.text = [MyHelperTool timeSpToTime:model.add_time];
    monthLb.textAlignment = NSTextAlignmentLeft;
    monthLb.font = SYSF750(25);
    [view addSubview:monthLb];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 420*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 420*PROPORTION750)];
    view.backgroundColor = [UIColor whiteColor];
    BillHisModel *model = self.billHisModels[section];
    NSArray *titles = @[@"发票详情",
                        [NSString stringWithFormat:@"公司抬头:%@", model.fptt],
                        @"发票内容：服务费",
                        [NSString stringWithFormat:@"发票金额：%@元", model.money],
                        [NSString stringWithFormat:@"收件人：%@", model.recive_user],
                        [NSString stringWithFormat:@"联系电话：%@", model.recive_phone],
                        [NSString stringWithFormat:@"收件地址：%@", model.recive_address]];
    for(int i = 0; i < titles.count; i++){
        if (i == 0) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-100*PROPORTION750, 30*PROPORTION750)];
            lable.text = titles[i];
            lable.font = SYSF750(30);
            lable.textAlignment = NSTextAlignmentLeft;
            [view addSubview:lable];
        }else{
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 90*PROPORTION750+(i-1)*55*PROPORTION750, AL_DEVICE_WIDTH-100*PROPORTION750, 25*PROPORTION750)];
            lable.text = titles[i];
            lable.font = SYSF750(25);
            lable.textAlignment = NSTextAlignmentLeft;
            [view addSubview:lable];
        }
    }
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.billHisModels[section].billModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"section = %d, row = %d", (int)indexPath.section, (int)indexPath.row];
    BillHisModel *model = self.billHisModels[indexPath.section];
    cell.model = model.billModels[indexPath.row];
    return cell;
}

//网络请求
-(void)loadData{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/bill_history" withParam:reqDic success:^(id responseObject) {
        
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200){
            NSArray *array = [responseObject arrayForKey:@"data"];
            self.billHisModels = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                BillHisModel *model = [[BillHisModel alloc] initWithDataSource:array[i]];
                [self.billHisModels addObject:model];
            }
            [self.myTableView reloadData];
        }else if (code == 300){
            
        }else if (code == 400){
            [self toast:msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
