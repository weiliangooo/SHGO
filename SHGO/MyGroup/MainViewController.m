//
//  MainViewController.m
//  SHGO
//
//  Created by Alen on 2017/3/22.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavViewController.h"

#import "CKLoginViewController.h"
#import "ChengKeMainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT/2)];
    button1.tag = 100;
    [button1 setTitle:@"我是乘客" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClickEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT/2, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT/2)];
    button2.tag = 200;
    [button2 setTitle:@"我是司机" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    
}

-(void)buttonClickEvents:(UIButton *)button
{
    if (button.tag == 100)
    {
        if ([USERDEFAULTS objectForKey:@"token"])
        {
            ChengKeMainViewController *viewController = [[ChengKeMainViewController alloc] init];
            BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
            [self presentViewController:navigationController  animated:YES completion:nil];
        }
        else
        {
            CKLoginViewController *viewController = [[CKLoginViewController alloc] init];
            BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
            [self presentViewController:navigationController  animated:YES completion:nil];
        }
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
