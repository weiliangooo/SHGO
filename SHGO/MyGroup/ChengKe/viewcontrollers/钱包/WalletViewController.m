//
//  CKWalletViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletMoneyModel.h"
#import "WalletDetailViewController.h"
#import "WalletQuanModel.h"

@interface WalletViewController ()
{
    NSString *user_wallet;
    NSString *user_money;
}
@end

@implementation WalletViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"我的钱包";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self loadData];
}

-(void)loadData{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/mypersonal" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200){
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
            user_wallet = [NSString stringWithFormat:@"%@元", [dic stringForKey:@"user_wallet"]];
            user_money = [NSString stringWithFormat:@"%@元", [dic stringForKey:@"user_money"]];
            [self loadUI];
        }else if (code == 300){
            [self toast:@"身份认证已过期"];
            [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
        }else if (code == 400){
            [self toast:msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadUI{
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 200*PROPORTION750)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.clipsToBounds = YES;
    myView.layer.cornerRadius = 15.0*PROPORTION750;
    [self.view addSubview:myView];
    
    NSArray *icons = @[@"money_wallet",@"redPack_wallet"];
    NSArray *titles = @[@"余额",@"红包"];
    NSArray *details = @[user_wallet, user_money];
    for (int i = 0; i < 2; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100*PROPORTION750*i, myView.width, 100*PROPORTION750)];
        view.tag = 100 +i;
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvents:)]];
        [myView addSubview:view];
        
        if(i != 1)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 98*PROPORTION750, view.width, 2*PROPORTION750)];
            line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            [view addSubview:line];
        }
        
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        headImg.clipsToBounds = YES;
        headImg.layer.cornerRadius = 15*PROPORTION750;
        headImg.image = [UIImage imageNamed:icons[i]];
        [view addSubview:headImg];
        
        UILabel *headLB = [[UILabel alloc] initWithFrame:CGRectMake(headImg.right+30*PROPORTION750, 35*PROPORTION750, 140*PROPORTION750, 30*PROPORTION750)];
        headLB.text = titles[i];
        headLB.font = SYSF750(30);
        headLB.textAlignment = NSTextAlignmentLeft;
        [view addSubview:headLB];
        
        UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(view.width-218*PROPORTION750, 35*PROPORTION750, 140*PROPORTION750, 30*PROPORTION750)];
        detailLB.text = details[i];
        detailLB.font = SYSF750(22);
        detailLB.textAlignment = NSTextAlignmentRight;
        [view addSubview:detailLB];
        
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(view.width-48*PROPORTION750, 35*PROPORTION750, 18*PROPORTION750, 30*PROPORTION750)];
        rightImage.image = [UIImage imageNamed:@"right_wallet"];
        [view addSubview:rightImage];
        
    }

}

-(void)tapEvents:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
        case 100:{
            [self requestDetailData:WalletTypeBalance];
        }
            break;
        case 101:{
           [self requestDetailData:WalletTypeRed];
        }
            break;
        default:
            break;
    }
}

-(void)requestDetailData:(WalletType)walletType{
    NSString *type;
    NSString *allMoney;
    if (walletType == WalletTypeBalance){
        type = @"user_wallet";
        allMoney = user_wallet;
    }else{
        type = @"user_money";
        allMoney = user_money;
    }
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   type,@"type",
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/waller_record" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            NSArray *array = [NSArray arrayWithArray:[responseObject arrayForKey:@"data"]];
            WalletMoneyModel *model = [[WalletMoneyModel alloc] initWithData:array];
            model.allMoney = allMoney;
            WalletDetailViewController *viewController = [[WalletDetailViewController alloc] initWithType:walletType dataSource:model];
            [self.navigationController pushViewController:viewController animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
