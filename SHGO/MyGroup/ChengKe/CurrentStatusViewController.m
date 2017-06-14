//
//  CurrentStatusViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/12.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CurrentStatusViewController.h"
#import "MyStar.h"
#import "UIImage+ScalImage.h"
#import "StatusViews.h"
#import "CancleOrderAlertView.h"
#import "ResonForCancleViewController.h"

@interface CurrentStatusViewController ()

@end

@implementation CurrentStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.gesturesEnabled = true;
    self.mapView.zoomEnabledWithTap = false;
    self.mapView.overlookEnabled = false;
    self.mapView.rotateEnabled = false;
    
    _curStatus = s_end;
    [self CreateUI];
}

-(void)loadData{
    
}

/********************** 刷新当前ui **********************/
-(void)refreshCurUI{
    if (_curStatus != _willStatus) {
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
    }
}

-(void)CreateUI{
    switch (_curStatus) {
        case s_start:{
            ((YHBaseViewController *)self.parentViewController).topTitle = @"等待派单中";
            S_StartView *view = [[S_StartView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-330*PROPORTION750-64, 690*PROPORTION750, 310*PROPORTION750) DataSource:nil];
            [self.view addSubview:view];
        }
            
            break;
        case s_waiting:{
            ((YHBaseViewController *)self.parentViewController).topTitle = @"司机正在路上";
            S_WatingView *view = [[S_WatingView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-450*PROPORTION750-64, 690*PROPORTION750, 430*PROPORTION750) DataSource:nil];
            [self.view addSubview:view];
            
            [self addHeadView:view];
        }
            break;
        case s_onWay:{
            ((YHBaseViewController *)self.parentViewController).topTitle = @"行程中";
            S_OnWayView *view = [[S_OnWayView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-350*PROPORTION750-64, 690*PROPORTION750, 330*PROPORTION750) DataSource:nil];
            [self.view addSubview:view];
        
            [self addHeadView:view];
        }
            break;
        case s_end:{
            ((YHBaseViewController *)self.parentViewController).topTitle = @"已完成";
            S_EndView *view = [[S_EndView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-845*PROPORTION750-64, 690*PROPORTION750, 825*PROPORTION750) DataSource:nil];
            [self.view addSubview:view];
            

            
            [self addHeadView:view];
            
        }
            break;
        default:
            break;
    }
}

-(void)addHeadView:(UIView *)view{
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(270*PROPORTION750, -50*PROPORTION750, 150*PROPORTION750, 150*PROPORTION750)];
    headImg.clipsToBounds = true;
    headImg.layer.cornerRadius = 75*PROPORTION750;
    headImg.layer.borderWidth = 5*PROPORTION750;
    headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    headImg.layer.shadowOpacity = 0.9;// 阴影透明度
    headImg.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    headImg.layer.shadowRadius = 30;// 阴影扩散的范围控制
    //            headImg.layer.shadowOffset  = CGSizeMake(1, 1);// 阴影的范围
    headImg.image = [UIImage imageNamed:@"default"];
    [view addSubview:headImg];
    
    UILabel *carNumLB = [[UILabel alloc] initWithFrame:CGRectMake(270*PROPORTION750, 80*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
    carNumLB.backgroundColor = [UIColor whiteColor];
    carNumLB.text = @"皖A11111";
    carNumLB.font = FONT750(30);
    carNumLB.textAlignment = NSTextAlignmentCenter;
    //            carNumLB.clipsToBounds = true;
    //            carNumLB.layer.cornerRadius = 15*PROPORTION750;
    //            carNumLB.layer.borderColor = [UIColor grayColor].CGColor;
    carNumLB.layer.shadowOpacity = 0.9;// 阴影透明度
    carNumLB.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    carNumLB.layer.shadowRadius = 3;// 阴影扩散的范围控制
    carNumLB.layer.shadowOffset  = CGSizeMake(1, 1);// 阴影的范围
    //            carNumLB.layer.borderWidth = 2*PROPORTION750;
    [view addSubview:carNumLB];
}

/********************** 刷新当前ui **********************/

-(void)canCleBtnClickEvent{
    CancleOrderAlertView *alerView = [[CancleOrderAlertView alloc] initWithTipTitle:@"是否需要取消订单" TipImage:nil];
    alerView.delegate =self;
}

-(void)AlertClassView:(id)alertView clickIndex:(NSInteger)index{
    [alertView removeFromSuperview];
    if (index == 100){
        ResonForCancleViewController *viewController = [[ResonForCancleViewController alloc] init];
//        viewController.orderNum = _orderNum;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    NSLog(@"%d",(int)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
