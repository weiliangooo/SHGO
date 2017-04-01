//
//  AppDelegate.m
//  SHGO
//
//  Created by Alen on 2017/2/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavViewController.h"
#import "MainViewController.h"
#import "PGSLeadViewController.h"
#import "CKLoginViewController.h"
#import "ChengKeMainViewController.h"
#import "CKRealNameViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置启动页面时间
    //    [NSThread sleepForTimeInterval:1.0];
    //    StartViewController *startVC = [[StartViewController alloc] init];
    //    self.window.rootViewController = startVC;
    
    //注册百度地图
    _BMManager = [[BMKMapManager alloc] init];
    BOOL ret = [_BMManager start:@"HG5lcpblG2wK7lyP9fVyHO5A9xMyPtub" generalDelegate:nil];
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
    /*
    //跳往选择界面 选择时司机还是乘客
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = mainVC;
    */
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([MyHelperNO  isFirstLogin])
    {
        [USERDEFAULTS setBool:YES forKey:@"hadLogin"];
        PGSLeadViewController *viewController = [[PGSLeadViewController alloc] init];
        self.window.rootViewController = viewController;
    }
    else
    {
        if ([MyHelperNO getMyToken].length == 0)
        {
            CKLoginViewController *viewController = [[CKLoginViewController alloc] init];
            BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
            
            self.window.rootViewController = navigationController;
        }
        else
        {
            if([MyHelperNO isHadAuthentication])
            {
                ChengKeMainViewController *viewController = [[ChengKeMainViewController alloc] init];
                BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
                navigationController.navigationBar.hidden = NO;
                
                self.window.rootViewController = navigationController;
            }
            else
            {
                CKRealNameViewController *viewController = [[CKRealNameViewController alloc] init];
                BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
                
                self.window.rootViewController = navigationController;
            }
        }
        
    }
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
