//
//  BaseNavViewController.m
//  CarMarket
//
//  Created by yangH4 on 15/12/30.
//
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    //通过背景图片来设置背景
 //   [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviBg"] forBarMetrics:UIBarMetricsDefault];

}

@end
