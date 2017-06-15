//
//  AppDelegate.h
//  SHGO
//
//  Created by Alen on 2017/2/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UITabBarController *tabBar;

@property (nonatomic, strong) BMKMapManager *BMManager;

@property (nonatomic, strong) NSString *noticeFlag;

@property (nonatomic, strong) MainViewController *mainVc;

@end

