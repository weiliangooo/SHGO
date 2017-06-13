//
//  CurrentStatusViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/12.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CurrentStatusViewController.h"

@interface CurrentStatusViewController ()

@end

@implementation CurrentStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = @"司机正在路上";
    
    self.mapView.gesturesEnabled = true;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
