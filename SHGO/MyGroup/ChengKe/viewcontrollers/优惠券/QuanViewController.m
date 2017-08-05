//
//  QuanViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "QuanViewController.h"
#import "WalletQuanModel.h"
#import "WalletDiscoutCell.h"
#import "MyWebViewController.h"
#import "UIImage+ScalImage.h"

@interface QuanViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *imgUrl;
}

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) WalletQuanModel* dataSource;

@end

@implementation QuanViewController

-(UITableView *)myTableView{
    if (!_myTableView){
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 0, 670*PROPORTION750, AL_DEVICE_HEIGHT-64) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = @"我的优惠券";
    self.type = 2;
    self.leftBtn.frame = CGRectMake(0, 0, 38*PROPORTION750, 30*PROPORTION750);
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20*PROPORTION750, 0, 0);
    [self.leftBtn setImage:[UIImage imageNamed:@"rowback"] forState:UIControlStateNormal];
    self.rightBtn.frame = CGRectMake(0, 0, 35*PROPORTION, 35*PROPORTION);
    [self.rightBtn setImage:[[UIImage imageNamed:@"what_right"] scaleImageByWidth:35*PROPORTION750] forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:self.myTableView];
    [self loadData];
}

-(void)loadData{
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
            self.dataSource = [[WalletQuanModel alloc] initWithData:array];
            [self.myTableView reloadData];
            imgUrl = [responseObject stringForKey:@"img"];
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

-(void)rightBtn:(UIButton *)button{
    MyWebViewController *viewController = [[MyWebViewController  alloc] initWithTopTitle:@"使用规则" urlString:@"https://m.xiaomachuxing.com/index/cproblem#coupon"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.listModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (![imgUrl isEqualToString:@"0"]) {
        return 220*PROPORTION750;
    }else{
        if (_dataSource.listModels.count == 0){
            return 90*PROPORTION750;
        }
        return 20*PROPORTION750;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (![imgUrl isEqualToString:@"0"]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 220*PROPORTION750)];
        view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10*PROPORTION750, 30*PROPORTION750, 690*PROPORTION750, 160*PROPORTION750)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        imageView.userInteractionEnabled = true;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)]];
        [view addSubview:imageView];
        return view;
    }else{
        if (_dataSource.listModels.count == 0){
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 90*PROPORTION750)];
            view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
            label.text = @"暂无优惠券";
            label.textColor = [UIColor colorWithHexString:@"999999"];
            label.font = SYSF750(30);
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            return view;
        }else{
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 20*PROPORTION750)];
            view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
            return view;
        }
    }
    
    
    
//    if (_dataSource.listModels.count == 0){
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 670*PROPORTION750, 90*PROPORTION750)];
//        view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
//        view.backgroundColor = [UIColor clearColor];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
//        label.text = @"暂无优惠券";
//        label.textColor = [UIColor colorWithHexString:@"999999"];
//        label.font = SYSF750(30);
//        label.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:label];
//        return view;
//    }
//    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 205*PROPORTION750;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletDiscoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[WalletDiscoutCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WalletQuanListModel *model = [[WalletQuanListModel alloc] init];
    model = ((WalletQuanModel *)_dataSource).listModels[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)imageTap:(UITapGestureRecognizer *)tap{
    MyWebViewController *viewController = [[MyWebViewController  alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
