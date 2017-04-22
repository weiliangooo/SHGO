//
//  OrderPriceDetailViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "OrderPriceDetailViewController.h"
#import "OrderPriceModel.h"

@interface OrderPriceDetailViewController ()

@end

@implementation OrderPriceDetailViewController


-(instancetype)initWithOrderPriceModel:(OrderPriceModel *)model
{
    if (self = [super init])
    {
        _orderPriceModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"查看明细";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 580*PROPORTION750)];
    backView.layer.cornerRadius = 15*PROPORTION750;
    backView.clipsToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *topLB = [[UILabel alloc] initWithFrame:CGRectMake(300*PROPORTION750, 30*PROPORTION750, 110*PROPORTION750, 25*PROPORTION750)];
    topLB.text = @"费用详情";
    topLB.textColor = [UIColor colorWithHexString:@"999999"];
    topLB.font = SYSF750(25);
    topLB.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:topLB];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5*PROPORTION750, 300*PROPORTION750, 2*PROPORTION750)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(410*PROPORTION750, 41.5*PROPORTION750, 300*PROPORTION750, 2*PROPORTION750)];
    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [backView addSubview:line2];
    
    NSMutableAttributedString *accoutPrice = [[NSMutableAttributedString alloc] initWithString:_orderPriceModel.need_price];
    [accoutPrice addAttribute:NSFontAttributeName value:SYSF750(50) range:NSMakeRange(0, accoutPrice.length-1)];
    [accoutPrice addAttribute:NSFontAttributeName value:SYSF750(25) range:NSMakeRange(accoutPrice.length-1, 1)];
    [accoutPrice addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, accoutPrice.length-1)];
    [accoutPrice addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(accoutPrice.length-1, 1)];
    
    UILabel *accoutPriceLB = [[UILabel alloc] initWithFrame:CGRectMake(0, topLB.bottom+30*PROPORTION750, 710*PROPORTION750, 50*PROPORTION750)];
    accoutPriceLB.textAlignment = NSTextAlignmentCenter;
    accoutPriceLB.attributedText = accoutPrice;
    [backView addSubview:accoutPriceLB];
    
    
    for (int i = 0 ; i < 5; i++)
    {
        switch (i) {
            case 0:
            {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, accoutPriceLB.bottom, 710*PROPORTION750, 80*PROPORTION750)];
                [backView addSubview:view];
                
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 27.5*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
                titleLB.text = @"基础价";
                titleLB.textColor = [UIColor colorWithHexString:@"999999"];
                titleLB.font = SYSF750(25);
                titleLB.textAlignment = NSTextAlignmentLeft;
                [view addSubview:titleLB];
                
                UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(530*PROPORTION750, 27.5*PROPORTION750, 150*PROPORTION750, 25*PROPORTION750)];
                detailLB.text = _orderPriceModel.base_price;
                detailLB.textColor = [UIColor colorWithHexString:@"999999"];
                detailLB.font = SYSF750(25);
                detailLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:detailLB];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 78*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
                line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
                [view addSubview:line];
            }
                break;
            case 1:
            {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, accoutPriceLB.bottom+80*PROPORTION750, 710*PROPORTION750, 125*PROPORTION750)];
                [backView addSubview:view];
                
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
                titleLB.text = @"超出免费送达范围费用";
                titleLB.textColor = [UIColor colorWithHexString:@"999999"];
                titleLB.font = SYSF750(25);
                titleLB.textAlignment = NSTextAlignmentLeft;
                [view addSubview:titleLB];
                
                UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 70*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
                tipLB.text = @"（起步10元+1.5元／公里）";
                tipLB.textColor = [UIColor colorWithHexString:@"#e1e1e1"];
                tipLB.font = SYSF750(25);
                tipLB.textAlignment = NSTextAlignmentLeft;
                [view addSubview:tipLB];
                
                UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(530*PROPORTION750, 50*PROPORTION750, 150*PROPORTION750, 25*PROPORTION750)];
                detailLB.text = _orderPriceModel.added_price;
                detailLB.textColor = [UIColor colorWithHexString:@"999999"];
                detailLB.font = SYSF750(25);
                detailLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:detailLB];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 123*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
                line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
                [view addSubview:line];
            }
                break;
            case 2:
            {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, accoutPriceLB.bottom+80*PROPORTION750+125*PROPORTION750, 710*PROPORTION750, 80*PROPORTION750)];
                [backView addSubview:view];
                
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 27.5*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
                titleLB.text = @"余额支付";
                titleLB.textColor = [UIColor colorWithHexString:@"999999"];
                titleLB.font = SYSF750(25);
                titleLB.textAlignment = NSTextAlignmentLeft;
                [view addSubview:titleLB];
                
                UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(530*PROPORTION750, 27.5*PROPORTION750, 150*PROPORTION750, 25*PROPORTION750)];
                detailLB.text = _orderPriceModel.user_wallet;
                detailLB.textColor = [UIColor colorWithHexString:@"999999"];
                detailLB.font = SYSF750(25);
                detailLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:detailLB];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 78*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
                line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
                [view addSubview:line];
            }
                break;
            case 3:
            {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, accoutPriceLB.bottom+80*PROPORTION750*2+125*PROPORTION750, 710*PROPORTION750, 80*PROPORTION750)];
                [backView addSubview:view];
                
                UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 27.5*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
                titleLB.text = _orderPriceModel.discountName;
                titleLB.textColor = [UIColor colorWithHexString:@"999999"];
                titleLB.font = SYSF750(25);
                titleLB.textAlignment = NSTextAlignmentLeft;
                [view addSubview:titleLB];
                
                UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(530*PROPORTION750, 27.5*PROPORTION750, 150*PROPORTION750, 25*PROPORTION750)];
                detailLB.text = _orderPriceModel.discountPrice;
                detailLB.textColor = [UIColor colorWithHexString:@"999999"];
                detailLB.font = SYSF750(25);
                detailLB.textAlignment = NSTextAlignmentRight;
                [view addSubview:detailLB];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 78*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
                line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
                [view addSubview:line];
            }
                break;
            case 4:
            {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, accoutPriceLB.bottom+80*PROPORTION750*3+125*PROPORTION750, 710*PROPORTION750, 80*PROPORTION750)];
                [backView addSubview:view];
                
                UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 25*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
                imageView1.image = [UIImage imageNamed:@"alipay"];
                [view addSubview:imageView1];
                
                UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(imageView1.right+20*PROPORTION750, 27.5*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
                lable1.text = @"随时退";
                lable1.textColor = [UIColor colorWithHexString:@"#19ae1a"];
                lable1.font = SYSF750(25);
                lable1.textAlignment = NSTextAlignmentLeft;
                [lable1 sizeToFit];
                [view addSubview:lable1];
                
                UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(lable1.right+60*PROPORTION750, 25*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
                imageView2.image = [UIImage imageNamed:@"alipay"];
                [view addSubview:imageView2];
                
                UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(imageView2.right+20*PROPORTION750, 27.5*PROPORTION750, 450*PROPORTION750, 25*PROPORTION750)];
                lable2.text = @"过期自动退";
                lable2.textColor = [UIColor colorWithHexString:@"#19ae1a"];
                lable2.font = SYSF750(25);
                lable2.textAlignment = NSTextAlignmentLeft;
                [lable2 sizeToFit];
                [view addSubview:lable2];
            }
                break;
                
            default:
                break;
        }
        
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
