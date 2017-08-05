//
//  CKOrderViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/8.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKOrderViewController.h"
#import "CKOrderDetailViewController.h"
#import "OrderListModel.h"
#import "OrderDetailModel.h"
#import "BillViewController.h"

@interface CKOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *unFinishdata;
@property (nonatomic, strong) NSMutableArray *finishdata;

@end

@implementation CKOrderViewController

-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 0, AL_DEVICE_WIDTH-40*PROPORTION750, AL_DEVICE_HEIGHT-64) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        _myTableView.mj_header = header;
    }
    return _myTableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 3;
//    [self.rightBtn setTitle:@"开发票" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"" forState:UIControlStateNormal];
    self.topTitle = @"我的行程";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:self.myTableView];
    
//    [self loadData];
}

-(void)loadData{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[MyHelperNO getUid], @"uid", [MyHelperNO getMyToken], @"token", nil];
    [self post:@"order/orderlist" withParam:reqDic success:^(id responseObject) {
        [_myTableView.mj_header endRefreshing];
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            _finishdata = [NSMutableArray array];
            _unFinishdata = [NSMutableArray array];
            NSArray *fin = [NSArray arrayWithArray:[responseObject arrayForKey:@"over"]];
            _finishdata = [NSMutableArray array];
            for (int i = 0 ; i < fin.count; i++)
            {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[fin objectAtIndex:i]];
                OrderListMemModel *model = [[OrderListMemModel alloc] initWithData:dic];
                [_finishdata addObject:model];
            }
            
            NSArray *unf = [NSArray arrayWithArray:[responseObject arrayForKey:@"doing"]];
            _unFinishdata = [NSMutableArray array];
            for (int i = 0 ; i < unf.count; i++)
            {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[unf objectAtIndex:i]];
                OrderListMemModel *model = [[OrderListMemModel alloc] initWithData:dic];
                [_unFinishdata addObject:model];
            }
            
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [_unFinishdata count];
    }
    else
    {
        return [_finishdata count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 85*PROPORTION750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH-40*PROPORTION750, 85*PROPORTION750)];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    if (section == 0)
    {
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 27.5*PROPORTION750, view.width, 30*PROPORTION750)];
        titleLB.text = @"未完成订单";
        titleLB.textColor = [UIColor colorWithHexString:@"#1bae1a"];
        titleLB.font = SYSF750(30);
        titleLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:titleLB];
    }
    else
    {
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 27.5*PROPORTION750, view.width, 30*PROPORTION750)];
        titleLB.text = @"已完成订单";
        titleLB.textColor = [UIColor colorWithHexString:@"#999999"];
        titleLB.font = SYSF750(30);
        titleLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:titleLB];
    }
    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 285*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CKOrderCell alloc] init];
    }
    
    OrderListMemModel *model;
    if (indexPath.section == 0)
    {
        model = [_unFinishdata objectAtIndex:indexPath.row];
    }
    else
    {
        model = [_finishdata objectAtIndex:indexPath.row];
    }
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderListMemModel *model;
    if (indexPath.section == 0)
    {
        model = [_unFinishdata objectAtIndex:indexPath.row];
    }
    else
    {
        model = [_finishdata objectAtIndex:indexPath.row];
    }
    
    CKOrderDetailViewController *viewController = [[CKOrderDetailViewController alloc] init];
    viewController.order_sn = model.order_sn;
    viewController.myTitle = model.type;
    [self.navigationController pushViewController:viewController animated:true];

}

-(void)alReLoadData{
    [self loadData];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self hideLoading];
    });
}

-(void)rightBtn:(UIButton *)button{
//    BillViewController *viewController = [[BillViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation CKOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 710*PROPORTION750, 255*PROPORTION750)];
        view.backgroundColor = [UIColor whiteColor];
        view.clipsToBounds = YES;
        view.layer.cornerRadius = 15*PROPORTION750;
        [self addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, 27.5*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 15*PROPORTION750;
        imageView.image = [UIImage imageNamed:@"time"];
        [view addSubview:imageView];
        
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+20*PROPORTION750, 27.5*PROPORTION750, 350*PROPORTION750, 30*PROPORTION750)];
        _timeLB.text = @"（今天）03-21 15:01（下单）";
        _timeLB.font = SYSF750(25);
        _timeLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:_timeLB];
        
        _stateLB = [[UILabel alloc] initWithFrame:CGRectMake(view.width-188*PROPORTION750, 27.5*PROPORTION750, 120*PROPORTION750, 30*PROPORTION750)];
        _stateLB.text = @"已完成";
        _stateLB.font = SYSF750(25);
        _stateLB.textAlignment = NSTextAlignmentRight;
        [view addSubview:_stateLB];
        
        UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(view.width-48*PROPORTION750, 27.5*PROPORTION750, 18*PROPORTION750, 30*PROPORTION750)];
        rightImgView.clipsToBounds = YES;
        rightImgView.layer.cornerRadius = 15*PROPORTION750;
        rightImgView.image = [UIImage imageNamed:@"right_wallet"];
        [view addSubview:rightImgView];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 83*PROPORTION750, view.width, 2*PROPORTION750)];
        line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [view addSubview:line1];
        
        
        UIView *greenView = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, line1.bottom+27.5*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        greenView.clipsToBounds = YES;
        greenView.layer.cornerRadius = 15*PROPORTION750;
        greenView.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        [view addSubview:greenView];
        
        _starPlaceLB = [[UILabel alloc] initWithFrame:CGRectMake(greenView.right+20*PROPORTION750, greenView.top, 500*PROPORTION750, 30*PROPORTION750)];
        _starPlaceLB.text = @"合肥市-财富广场";
        _starPlaceLB.font = SYSF750(25);
        _starPlaceLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:_starPlaceLB];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 168*PROPORTION750, view.width, 2*PROPORTION750)];
        line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [view addSubview:line2];
        
        UIView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(30*PROPORTION750, line2.bottom+27.5*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        redView.clipsToBounds = YES;
        redView.layer.cornerRadius = 15*PROPORTION750;
        redView.backgroundColor = [UIColor colorWithHexString:@"#ff4f00"];
        [view addSubview:redView];
        
        _endPlaceLB = [[UILabel alloc] initWithFrame:CGRectMake(redView.right+20*PROPORTION750, redView.top, 500*PROPORTION750, 30*PROPORTION750)];
        _endPlaceLB.text = @"桐城市-青草镇";
        _endPlaceLB.font = SYSF750(25);
        _endPlaceLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:_endPlaceLB];

        
    }
    return self;
}

-(void)setModel:(OrderListMemModel *)model
{
    _model = model;
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[_model.order_time integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    _timeLB.text = [NSString stringWithFormat:@"%@（下单）", confromTimespStr];
    
    _stateLB.text = _model.type;
    
    _starPlaceLB.text = _model.s_name;
    _endPlaceLB.text = _model.e_name;
    
}


@end

