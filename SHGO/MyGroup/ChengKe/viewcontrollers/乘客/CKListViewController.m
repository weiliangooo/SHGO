//
//  CKListViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKListViewController.h"
#import "CKEditCKMsgViewController.h"
#import "CKAddCKMsgViewController.h"

@interface CKListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation CKListViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 0, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-64) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"乘客管理";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    [self.view addSubview:self.myTableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 19;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 85*PROPORTION750)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*PROPORTION750, 30*PROPORTION750, view.width, 25*PROPORTION750)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"当前用户";
    label.font = SYSF750(25);
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    [view addSubview:label];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 85*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 160*PROPORTION750)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50*PROPORTION750, view.width, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(addBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 160*PROPORTION750;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CKListCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.changeBlock = ^(){
        CKEditCKMsgViewController *viewController = [[CKEditCKMsgViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    };
//    cell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return cell;
}

-(void)addBtnClickEvent:(UIButton *)button
{
    CKAddCKMsgViewController *viewController = [[CKAddCKMsgViewController alloc] init];
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


@implementation CKListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _nameLB = [[UILabel alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 120*PROPORTION750, 30*PROPORTION750)];
        _nameLB.text = @"芬达";
        _nameLB.font = SYSF750(30);
        _nameLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLB];
        
        _idLB = [[UILabel alloc] initWithFrame:CGRectMake(_nameLB.right, 30*PROPORTION750, 300*PROPORTION750, 30*PROPORTION750)];
        _idLB.text = @"34012211995****1234";
        _idLB.font = SYSF750(22);
        _idLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_idLB];
        
        _phoneLB = [[UILabel alloc] initWithFrame:CGRectMake(_idLB.right, 30*PROPORTION750, 200*PROPORTION750, 30*PROPORTION750)];
        _phoneLB.text = @"135****1234";
        _phoneLB.font = SYSF750(22);
        _phoneLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_phoneLB];
        
        _changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(AL_DEVICE_WIDTH-100*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        [_changeBtn setImage:[UIImage imageNamed:@"edit_icon"] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_changeBtn];
    }
    return self;
}

-(void)buttonClickEvent:(UIButton *)button
{
    self.changeBlock();
}

@end










