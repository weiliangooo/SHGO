//
//  AppDelegate.m
//  SHGO
//
//  Created by Alen on 2017/2/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavViewController.h"
#import "PGSLeadViewController.h"
#import "CKLoginViewController.h"
#import "CKMainViewController.h"
#import "CKRealNameViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()<WXApiDelegate>

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
                CKMainViewController *viewController = [[CKMainViewController alloc] init];
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
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58eb3cba2ae85b3d5e001d27"];
    
    [self configUSharePlatforms];
    
    return YES;
}


- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx6c8ba4f0f1cdd17f" appSecret:@"37aeeecf6da4bb7990562c54ba858feb" redirectURL:@"https://m.xiaoma.com"];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx96f0e15a8ab1ac0e" appSecret:@"" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏wx96f0e15a8ab1ac0e wx6c8ba4f0f1cdd17f
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106092284"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
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
    //创建一个消息对象
    if (_noticeFlag != nil) {
        NSNotification * notice = [NSNotification notificationWithName:_noticeFlag object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // 其他如支付等SDK的回调
    if ([url.host isEqualToString:@"pay"] && [url.scheme isEqualToString:@"wx4a3b7ba9ccd06971"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    
    if ([url.host isEqualToString:@"safepay"])
    {
        NSLog(@"支付宝返回url_2： = %@", url);
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSString *status = resultDic[@"resultStatus"];
            
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"zhifubaonotice" object:nil userInfo:@{@"status":status}];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }];
        
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
        }];
    }
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        
    }
    return result;
}

//微信回调
-(void)onResp:(BaseResp *)resp
{//微信支付回调函数
    //    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"weixinnotice" object:nil userInfo:@{@"status":[NSString stringWithFormat:@"%d",resp.errCode]}];
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
    
}


@end
