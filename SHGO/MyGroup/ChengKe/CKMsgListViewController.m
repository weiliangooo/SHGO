//
//  CKMsgListViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/25.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMsgListViewController.h"
#import "CKMsgDetailViewController.h"
#import "MsgListModel.h"

@interface CKMsgListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *myTableView;

@property (nonatomic, strong)MsgListModel *msglistModel;

@end

@implementation CKMsgListViewController


-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 0, 710*PROPORTION750, AL_DEVICE_HEIGHT-64) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = @"消息";
    self.type = 1;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    [self.view addSubview:self.myTableView];
    [self loadData];
}

-(void)loadData
{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/member_msg" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            NSArray *array = [NSArray arrayWithArray:[responseObject arrayForKey:@"data"]];
            _msglistModel = [[MsgListModel alloc] initWith:array];
            [self.myTableView reloadData];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _msglistModel.msgModels.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MsgModel *model = [[MsgModel alloc] init];
    model = _msglistModel.msgModels[section];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 710*PROPORTION750, 80*PROPORTION750)];
    titleLB.text = model.sendTime;
    titleLB.backgroundColor = [UIColor clearColor];
    titleLB.font = SYSF750(20);
    titleLB.textAlignment = NSTextAlignmentCenter;
    return titleLB;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80*PROPORTION750;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKMsgListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CKMsgListCell alloc] init];
    }
    MsgModel *model = [[MsgModel alloc] init];
    model = _msglistModel.msgModels[indexPath.section];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MsgModel *model = [[MsgModel alloc] init];
    model = _msglistModel.msgModels[indexPath.section];
    if (model.msgWebUrl.length < 5)
    {
        CKMsgDetailViewController *viewController = [[CKMsgDetailViewController alloc] init];
        viewController.model = model;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
    
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




@implementation CKMsgListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15*PROPORTION750;
        self.layer.borderWidth = 2*PROPORTION750;
        self.layer.borderColor = [UIColor colorWithHexString:@"#1aad19"].CGColor;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 40*PROPORTION750, 35*PROPORTION750)];
        [self addSubview:imageView];
        
        titleLB = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+15*PROPORTION750, 35*PROPORTION750, 520*PROPORTION750, 25*PROPORTION750)];
        titleLB.text = @"【小马出行】温馨提示";
        titleLB.font = SYSF750(25);
        titleLB.textColor = [UIColor colorWithHexString:@"#1aad19"];
        titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLB];
        
        _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+15*PROPORTION750, titleLB.bottom+30*PROPORTION750, 580*PROPORTION750, 30*PROPORTION750)];
        _contentLB.font = SYSF750(30);
        _contentLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_contentLB];
        
    }
    return self;
}

-(void)setModel:(MsgModel *)model
{
    _model = model;
    _contentLB.text = _model.msgContent;
    if (_model.isRead)
    {
        self.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        titleLB.textColor = [UIColor colorWithHexString:@"999999"];
        _contentLB.textColor = [UIColor colorWithHexString:@"999999"];
        imageView.image = [UIImage imageNamed:@"msg_tip_no"];
    }
    else
    {
        self.layer.borderColor = [UIColor colorWithHexString:@"#1aad19"].CGColor;
        titleLB.textColor = [UIColor colorWithHexString:@"1aad19"];
        _contentLB.textColor = [UIColor blackColor];
        imageView.image = [UIImage imageNamed:@"msg_tip_yes"];
    }
}

@end


























