//
//  PayViewController.h
//  RentOutProject
//
//  Created by Alen on 16/8/18.
//  Copyright © 2016年 Abel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBaseViewController.h"
#import "AppDelegate.h"

#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "DataSigner.h"

#import "WXApi.h"


@interface PayViewController : YHBaseViewController <WXApiDelegate>

@property (nonatomic, strong) id<WXApiDelegate> delegate;
@property (nonatomic, copy) void (^paySuccBack)();
@property (nonatomic, copy) void (^checkPaySN)();
//预支付网关url地址
@property (nonatomic,strong) NSString* payUrl;

//debug信息
@property (nonatomic,strong) NSMutableString *debugInfo;
@property (nonatomic,assign) NSInteger lastErrCode;//返回的错误码

//商户关键信息
@property (nonatomic,strong) NSString *appId,*mchId,*spKey;


+(PayViewController *)shareManager;

-(void)zhifubaoInit:(id)responseObject;

-(void)weinxinInit:(id)responseObject;




@end
