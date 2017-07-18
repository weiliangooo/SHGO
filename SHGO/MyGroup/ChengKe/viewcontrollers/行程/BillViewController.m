//
//  BillViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/7/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableViewCell.h"
#import "UIImage+ScalImage.h"
#import "BillSubmitViewController.h"
#import "BillHistoryViewController.h"
#import "BillModel.h"

@interface BillViewController ()<UITableViewDelegate, UITableViewDataSource>{
    BOOL flag[100];
    UILabel *tipLb;
    NSInteger number;
    double price;
    
    UIButton *allBtn;
}

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray<BillModel *> *billModels;

@end

@implementation BillViewController

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 0, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-64-155*PROPORTION750) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[BillTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = @"按行程开发票";
    self.type = 3;
    [self.rightBtn setTitle:@"开票历史" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    
    [self.view addSubview:self.myTableView];
    
    UIView *bottomView= [[UIView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-64-145*PROPORTION750, AL_DEVICE_WIDTH, 145*PROPORTION750)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    allBtn = [[UIButton alloc] initWithFrame:CGRectMake(50*PROPORTION750, 30*PROPORTION750, 120*PROPORTION750, 40*PROPORTION750)];
    [allBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    allBtn.titleLabel.font = SYSF750(30);
    allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10*PROPORTION750, 0, 0);
    [allBtn setImage:[[UIImage imageNamed:@"ckunselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateNormal];
    [allBtn setImage:[[UIImage imageNamed:@"ckselected"] scaleImageByWidth:40*PROPORTION750] forState:UIControlStateSelected];
    [allBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:allBtn];
    
    tipLb = [[UILabel alloc] initWithFrame:CGRectMake(50*PROPORTION750, allBtn.bottom+20*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
    tipLb.font = SYSF750(25);
    tipLb.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:tipLb];
    [self setUpTipLbText:@""];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-250*PROPORTION750, 32.5*PROPORTION750, 200*PROPORTION750, 80*PROPORTION750)];
    nextBtn.backgroundColor = [UIColor colorWithHexString:@"#ff4f00"];
    nextBtn.layer.cornerRadius = 10*PROPORTION750;
    nextBtn.clipsToBounds = true;
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = SYSF750(35);
    [nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:nextBtn];
    
    number = 0;
    price = 0.0;
    
    [self loadData];
};
//bottomView handle
-(void)setUpTipLbText:(NSString *)text{
    NSMutableAttributedString *maString ;
    if (text.length == 0) {
        maString = [[NSMutableAttributedString alloc] initWithString:@"您还没有选择行程"];
        [maString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, maString.length)];
    }else{
        NSString *numS = [NSString stringWithFormat:@"%d", (int)number];
        NSString *priceS = [NSString stringWithFormat:@"%.2f", price];
        maString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@个行程 共%@元（满500包邮）", numS, priceS]];
        [maString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#8bcf8c"] range:NSMakeRange(0, numS.length)];
        [maString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff4f00"] range:NSMakeRange(5+numS.length, priceS.length)];
    }
    tipLb.attributedText = maString;
}

-(void)refreshTipLable{
    number = 0;
    price = 0.00;
    for (int i = 0; i < _billModels.count; i++) {
        if (flag[i]) {
            price = price + [_billModels[i].money doubleValue];
            number ++;
        }
    }
    if (number == 0) {
        [self setUpTipLbText:@""];
    }else{
        [self setUpTipLbText:@"1"];
    }
    
    if (number == _billModels.count) {
        allBtn.selected = true;
    }else{
        allBtn.selected = false;
    }
}

-(void)allBtnClicked:(UIButton *)button{
    button.selected = !button.selected;
    for (int i = 0 ; i < 100; i++) {
        flag[i] = button.selected;
    }
    
    if (button.selected) {
        number = _billModels.count;
        price = 0.00;
        for (BillModel *model in _billModels){
            price = price + [model.money doubleValue];
        }
    }else{
        number = 0;
        price = 0.00;
    }
    
    if (number == 0) {
        [self setUpTipLbText:@""];
    }else{
        [self setUpTipLbText:@"1"];
    }
    
    [self.myTableView reloadData];
}

//uitableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _billModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 80*PROPORTION750)];
//    UILabel *monthLb = [[UILabel alloc] initWithFrame:CGRectMake(10*PROPORTION750, 25*PROPORTION750, 250*PROPORTION750, 30*PROPORTION750)];
//    monthLb.text = @"03月";
//    monthLb.textAlignment = NSTextAlignmentLeft;
//    monthLb.font = SYSF750(25);
//    [headView addSubview:monthLb];
    
//    if (section == 0) {
        UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-250*PROPORTION750, 25*PROPORTION750, 190*PROPORTION750, 30*PROPORTION750)];
        [detailBtn setTitle:@"开票金额说明" forState:UIControlStateNormal];
        [detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        detailBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        detailBtn.titleLabel.font = SYSF750(25);
        [detailBtn addTarget:self action:@selector(detailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:detailBtn];
//    }
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"section = %d, row = %d", (int)indexPath.section, (int)indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    int cellIndex = 0;
    for(int i= 0 ; i < indexPath.section ; i++){
        cellIndex += [tableView numberOfRowsInSection:i];
    }
    cellIndex += indexPath.row;
    if (flag[cellIndex]) {
        cell.isSelected = true;
    }else{
        cell.isSelected = false;
    }
    cell.model = self.billModels[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    int cellIndex = 0;
    for(int i= 0 ; i < indexPath.section ; i++){
        cellIndex += [tableView numberOfRowsInSection:i];
    }
    cellIndex += indexPath.row;
    
    BillTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (flag[cellIndex]) {
        cell.isSelected = false;
    }else{
        cell.isSelected = true;
    }
    
    flag[cellIndex] = !flag[cellIndex];
    [self refreshTipLable];
}

//开票金额说明
-(void)detailBtnClicked:(UIButton *)button{
    UIAlertController *viewController = [UIAlertController alertControllerWithTitle:@"" message:@"行程消费中包含的优惠券、红包、余额不支持开具发票，企业支付的行程也不支持开票。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [viewController addAction:sureBtn];
    [self presentViewController:viewController animated:true completion:nil];
}

//下一步
-(void)nextBtnClicked:(UIButton *)button{
    NSMutableArray<BillModel *> *nextArray = [NSMutableArray array];
    for (int i = 0; i < _billModels.count; i++) {
        if (flag[i]) {
            [nextArray addObject:_billModels[i]];
        }
    }
    
    if (number > 0) {
        BillSubmitViewController *viewController = [[BillSubmitViewController alloc] init];
        viewController.dataArray = nextArray;
        [self.navigationController pushViewController:viewController animated:true];
    }else{
        [self toast:@"你还没有选择行程"];
    }
    
}

-(void)rightBtn:(UIButton *)button{
    BillHistoryViewController *viewcontroller = [[BillHistoryViewController alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:true];
}

//网络请求
-(void)loadData{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [MyHelperNO getUid], @"uid",
                                   @"2",@"type",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/bill_list" withParam:reqDic success:^(id responseObject) {
        
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200){
            _billModels = [NSMutableArray array];
            NSArray *array = [responseObject arrayForKey:@"data"];
            for (int i = 0; i < array.count; i++) {
                BillModel *model = [[BillModel alloc] initWithDataSource:array[i]];
                [_billModels addObject:model];
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
