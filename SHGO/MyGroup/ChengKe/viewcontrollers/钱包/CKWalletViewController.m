//
//  CKWalletViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKWalletViewController.h"
#import "WalletMoneyModel.h"
#import "WalletDetailViewController.h"
#import "WalletQuanModel.h"

@interface CKWalletViewController ()
{
    NSString *user_wallet;
    NSString *user_money;
    NSString *coupon;
}

@end

@implementation CKWalletViewController

-(void)viewWillAppear:(BOOL)animated
{
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

-(void)loadData
{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self post:@"user/mypersonal" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
            user_wallet = [NSString stringWithFormat:@"%@元", [dic stringForKey:@"user_wallet"]];
            user_money = [NSString stringWithFormat:@"%@元", [dic stringForKey:@"user_money"]];
            coupon = [NSString stringWithFormat:@"%@个", [dic stringForKey:@"coupon"]];
            [self loadUI];
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

-(void)loadUI
{
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, AL_DEVICE_WIDTH-40*PROPORTION750, 300*PROPORTION750)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.clipsToBounds = YES;
    myView.layer.cornerRadius = 15.0*PROPORTION750;
    [self.view addSubview:myView];
    
    NSArray *icons = @[@"money_wallet",@"redPack_wallet",@"discount_wallet"];
    NSArray *titles = @[@"余额",@"红包",@"优惠券"];
    NSArray *details = @[user_wallet, user_money, coupon];
    for (int i = 0; i < 3; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100*PROPORTION750*i, myView.width, 100*PROPORTION750)];
        view.tag = 100 +i;
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvents:)]];
        [myView addSubview:view];
        
        if(i != 2)
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

-(void)tapEvents:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 100:
        {
            [self requestDetailData:WalletTypeBalance];
        }
            break;
        case 101:
        {
           [self requestDetailData:WalletTypeRed];
        }
            break;
        case 102:
        {
            [self requestDetailData:WalletTypeDiscount];
        }
            break;
            
        default:
            break;
    }
}

-(void)requestDetailData:(WalletType)walletType
{
    if (walletType == WalletTypeBalance || walletType == WalletTypeRed)
    {
        NSString *type;
        NSString *allMoney;
        if (walletType == WalletTypeBalance)
        {
            type = @"user_wallet";
            allMoney = user_wallet;
        }
        else
        {
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
    else
    {
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [MyHelperNO getUid], @"uid",
                                       [MyHelperNO getMyToken], @"token", nil];
        [self post:@"user/coupon" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSLog(@"%@", responseObject);
            NSString *msg = [responseObject stringForKey:@"msg"];
            if (code == 200)
            {
                NSArray *array = [NSArray arrayWithArray:[responseObject arrayForKey:@"data"]];
                if(array.count == 0)
                {
                    [self toast:@"您还没有优惠券"];
                    return;
                }
                WalletQuanModel *model = [[WalletQuanModel alloc] initWithData:array];
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
