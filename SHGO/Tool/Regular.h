//
//  Regular.h
//  YFfarm
//
//  Created by zw on 16/5/31.
//  Copyright © 2016年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regular : NSObject

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL) validatePassword:(NSString *)passWord;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;

#pragma 正则匹配用户身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) checkCardNo:(NSString*) cardNo;
@end
