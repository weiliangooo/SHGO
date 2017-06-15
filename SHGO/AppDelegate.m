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
#import "LoginViewController.h"
#import "CKMainViewController.h"
#import "CKRealNameViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "MainViewController.h"

@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ///极光推送
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"096a2ae58b6a3b5a6d49ffc1" channel:@"App Store" apsForProduction:false];
    
    //注册百度地图
    _BMManager = [[BMKMapManager alloc] init];
    BOOL ret = [_BMManager start:@"HG5lcpblG2wK7lyP9fVyHO5A9xMyPtub" generalDelegate:nil];
    if (!ret){
        NSLog(@"manager start failed!");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([MyHelperNO  isFirstLogin]){
        [USERDEFAULTS setBool:YES forKey:@"hadLogin"];
        PGSLeadViewController *viewController = [[PGSLeadViewController alloc] init];
        self.window.rootViewController = viewController;
    }else{
        if ([MyHelperNO getMyToken].length == 0){
            LoginViewController *viewController = [[LoginViewController alloc] init];
            BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
            self.window.rootViewController = navigationController;
        }else{
            if([MyHelperNO isHadAuthentication]){
//                CKMainViewController *viewController = [[CKMainViewController alloc] init];
//                BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
//                navigationController.navigationBar.hidden = NO;
//                self.window.rootViewController = navigationController;
                
                _mainVc = [[MainViewController alloc] init];
                BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:_mainVc];
                navigationController.navigationBar.hidden = NO;
                self.window.rootViewController = navigationController;
            }else{
                CKRealNameViewController *viewController = [[CKRealNameViewController alloc] init];
                BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
                self.window.rootViewController = navigationController;
            }
        }
        
    }
    ///配置友盟
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58eb3cba2ae85b3d5e001d27"];
    [self configUSharePlatforms];
    
    return YES;
}

- (void)configUSharePlatforms{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx6c8ba4f0f1cdd17f" appSecret:@"37aeeecf6da4bb7990562c54ba858feb" redirectURL:@"https://m.xiaoma.com"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106092284"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}

///jpush
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

// Required, iOS 7 Support
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
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
    //创建一个消息对象//发送消息
    if (_noticeFlag != nil) {
        NSNotification * notice = [NSNotification notificationWithName:_noticeFlag object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    ///微信支付回调
    if ([url.host isEqualToString:@"pay"] && [url.scheme isEqualToString:@"wx6c8ba4f0f1cdd17f"]){
        return [WXApi handleOpenURL:url delegate:self];
    }
    ///支付宝支付回调
    if ([url.host isEqualToString:@"safepay"]){
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *status = resultDic[@"resultStatus"];
            //创建一个消息对象//发送消息
            NSNotification * notice = [NSNotification notificationWithName:@"zhifubaonotice" object:nil userInfo:@{@"status":status}];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }];
    }
    //支付宝钱包快登授权返回 authCode
    if ([url.host isEqualToString:@"platformapi"]){
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *status = resultDic[@"resultStatus"];
            //创建一个消息对象//发送消息
            NSNotification * notice = [NSNotification notificationWithName:@"zhifubaonotice" object:nil userInfo:@{@"status":status}];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }];
    }
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响 分享回调
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
    }
    return result;
}

//微信回调
-(void)onResp:(BaseResp *)resp{
    if([resp isKindOfClass:[PayResp class]]){
        //创建一个消息对象//发送消息
        NSNotification * notice = [NSNotification notificationWithName:@"weixinnotice" object:nil userInfo:@{@"status":[NSString stringWithFormat:@"%d",resp.errCode]}];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
}


@end
