//
//  ResonForCancleViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/17.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ResonForCancleViewController.h"
#import "CKMainViewController.h"

@interface ResonForCancleViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSArray *titles;
    
    NSInteger selectTip;
    
    UITextView *textView;
}
@property (nonatomic, strong)UITableView *myTableView;

@end

@implementation ResonForCancleViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 100) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.clipsToBounds = YES;
        _myTableView.layer.cornerRadius = 15*PROPORTION750;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"取消原因";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    selectTip = 100;
    
    titles = @[@"1.行程有变，暂时不需要用车",
               @"2.订单信息填写有误，需重新下单",
               @"3.联系不上司机或客服",
               @"4.不想坐了，选择乘坐其他交通工具",
               @"5.价格太高",
               @"6.其他原因"];
    
    self.myTableView.height = [self calTableViewHeightWithCellMaxNum:5 cellNum:6 cellHeight:85*PROPORTION750 headerHeight:145*PROPORTION750 footHeight:180*PROPORTION750];
    
    NSLog(@"%.2f", _myTableView.height);
    
    [self.view addSubview:self.myTableView];
    
    UIButton *subBT = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, _myTableView.bottom+30*PROPORTION750, AL_DEVICE_WIDTH-60*PROPORTION750, 90*PROPORTION750)];
    subBT.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    [subBT setTitle:@"提交" forState:UIControlStateNormal];
    subBT.titleLabel.font = SYSF750(40);
    subBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    subBT.clipsToBounds = YES;
    subBT.layer.cornerRadius = 15.0f*PROPORTION750;
    subBT.tag = 101;
    [subBT addTarget:self action:@selector(subClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subBT];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 145*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 710*PROPORTION750, 145*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *topTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*PROPORTION750, backView.width, 30*PROPORTION750)];
    topTitleLB.text = @"行程已取消，请告诉我们原因";
    topTitleLB.font = SYSF750(30);
    topTitleLB.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:topTitleLB];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, topTitleLB.bottom+30*PROPORTION750, backView.width, 25*PROPORTION750)];
    tipLB.text = @"我们会努力为您提供更好的服务";
    tipLB.textColor = [UIColor colorWithHexString:@"#1aad1a"];
    tipLB.font = SYSF750(25);
    tipLB.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:tipLB];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 143*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backView addSubview:line];
    
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 180*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 710*PROPORTION750, 180*PROPORTION750)];
    backView.backgroundColor = [UIColor whiteColor];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 630*PROPORTION750, 120*PROPORTION750)];
    textView.clipsToBounds = YES;
//    textView.delegate = self;
    textView.returnKeyType = UIReturnKeyDone;
    textView.layer.cornerRadius = 15*PROPORTION750;
    textView.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
    textView.layer.borderWidth = 2*PROPORTION750;
    [backView addSubview:textView];
    
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[ResonCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = titles[indexPath.row];
    cell.selectBlock = ^(){
        selectTip = indexPath.row;
        [self.myTableView reloadData];
    };
    if (indexPath.row == selectTip)
    {
        cell.isSelected = YES;
    }
    else
    {
        cell.isSelected = NO;
    }
    return cell;
}

-(void)keyboardWasShown:(NSNotification*)aNotification
{
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyBoardFrame.origin.y < self.myTableView.bottom)
    {
        [UIView animateWithDuration:1.0f animations:^{
            self.view.frame = CGRectMake(0, -keyBoardFrame.origin.y+self.myTableView.bottom, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
        }];
    }
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:1.0f animations:^{
        self.view.frame = CGRectMake(0, 64, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT);
    }];
    
}

-(void)subClickEvent
{
    NSString *upTitle;
    if (textView.text.length == 0)
    {
        if (selectTip == 100)
        {
            [self toast:@"请填写原因"];
            return;
        }
        upTitle = titles[selectTip];
    }
    else
    {
        upTitle = textView.text;
    }
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _orderNum, @"order_sn",
                                   upTitle,@"reason",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"order/order_cansle" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            [self toast:@"提交成功"];
            
            [self performSelector:@selector(popToMainVC) withObject:nil afterDelay:1.5f];
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

-(void)popToMainVC
{
    for (YHBaseViewController *viewController in self.navigationController.viewControllers)
    {
        if ([viewController isKindOfClass:[CKMainViewController class]]) {
            CKMainViewController *mainVC = (CKMainViewController *)viewController;
            [self.navigationController popToViewController:mainVC animated:YES];
        }
    }
}

-(CGFloat)calTableViewHeightWithCellMaxNum:(NSInteger)cellMaxNum
                                   cellNum:(NSInteger)cellNum
                                cellHeight:(CGFloat)cellHeight
                              headerHeight:(CGFloat)headerHeight
                                footHeight:(CGFloat)footHeight

{
    if (cellNum>cellMaxNum)
    {
        return cellMaxNum*cellHeight+headerHeight+footHeight;
    }
    return cellNum*cellHeight+headerHeight+footHeight;
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





@implementation ResonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 500*PROPORTION750, 25*PROPORTION750)];
        _titleLB.font = SYSF750(25);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _checkView = [[UIImageView alloc] initWithFrame:CGRectMake(635*PROPORTION750, 25*PROPORTION750, 35*PROPORTION750, 35*PROPORTION750)];
        _checkView.image = [UIImage imageNamed:@"ckunselected"];
        _checkView.userInteractionEnabled = YES;
        [_checkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)]];
        [self addSubview:_checkView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 83*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
    }
    return self;
}

-(void)tapEvent
{
    self.selectBlock();
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected)
    {
        _checkView.image = [UIImage imageNamed:@"ckselected"];
    }
    else
    {
        _checkView.image = [UIImage imageNamed:@"ckunselected"];
    }
}

@end





















