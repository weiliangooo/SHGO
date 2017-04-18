//
//  CKDiscountViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKDiscountViewController.h"
#import "CKDiscountRegularViewController.h"

@interface CKDiscountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation CKDiscountViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 0, 670*PROPORTION750, AL_DEVICE_HEIGHT-64) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.type = 1;
    self.topTitle = @"我的优惠券";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    [self.view addSubview:self.myTableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 90*PROPORTION750)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    UIButton *tipBtn = [[UIButton alloc] initWithFrame:CGRectMake(520*PROPORTION750, 30*PROPORTION750, 150*PROPORTION750, 30*PROPORTION750)];
    [tipBtn setImage:[UIImage imageNamed:@"regular_wallet"] forState:UIControlStateNormal];
    [tipBtn setTitle:@"使用规则" forState:UIControlStateNormal];
    [tipBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    tipBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    tipBtn.titleLabel.font = SYSF750(25);
    [tipBtn addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:tipBtn];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CKDiscountCell alloc] init];
    }
    return cell;
}

-(void)buttonClickEvent:(UIButton *)button
{
    CKDiscountRegularViewController *viewController = [[CKDiscountRegularViewController alloc] init];
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

@interface CKDiscountCell()

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) UILabel *timeLB;

@end

@implementation CKDiscountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 175*PROPORTION750)];
        bgImageView.image = [UIImage imageNamed:@"discout_Bg"];
        [self addSubview:bgImageView];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 32.5*PROPORTION750, 200*PROPORTION750, 40*PROPORTION750)];
        _titleLB.text = @"优惠券";
        _titleLB.font = SYSF750(40);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _priceLB = [[UILabel alloc] initWithFrame:CGRectMake(370*PROPORTION750, 22.5*PROPORTION750, 240*PROPORTION750, 60*PROPORTION750)];
        _priceLB.text = @"5.00¥";
        _priceLB.font = SYSF750(60);
        _priceLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_priceLB];
        
        
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 135*PROPORTION750, 400*PROPORTION750, 25*PROPORTION750)];
        _timeLB.text = @"有效期至2017-03-21";
        _timeLB.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLB.font = SYSF750(25);
        _timeLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLB];
    }
    return self;
}

@end




























