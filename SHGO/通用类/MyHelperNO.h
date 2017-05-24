//
//  MyHelperNO.h
//  GoodWallet
//
//  Created by Alen on 2017/1/3.
//  Copyright © 2017年 Abel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHelperNO : NSObject

+(MyHelperNO *)shareInstance;

//判断是否是第一次登录
+(BOOL)isFirstLogin;

//token
+(NSString *)getMyToken;

///判断是否已经实名认证
+(BOOL)isHadAuthentication;

///获取用户id uid
+(NSString *)getUid;

//用户名
+(NSString *)getMyUsername;

//手机号码
+(NSString *)getMyMobilePhone;

//身份证号
+(NSString *)getMyIdentNo;

//真实姓名
+(NSString *)getMyRealName;

//用户图片
+(NSString *)getMyHeadImage;

//移除userdefault 中所有数据
+(void)removeAllData;

//今天是否弹出广告
+(BOOL)canPreAdView;

//存储弹广告的时间
+(void)savePreTime;

//服务器版本
+(void)saveServerVersion:(NSString *)newVersion;
+(NSString *)getServerVersion;

+(void)saveServerLink:(NSString *)link;
+(NSString *)getServerLink;

+ (NSString *)getIpAddresses;

@end
