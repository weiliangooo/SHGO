//
//  YHHelpper.h
//  benben
//
//  Created by xunao on 15-2-27.
//  Copyright (c) 2015年 xunao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface YHHelpper : NSObject
//去掉空格
+(NSString*)trim:(NSString*)string;
+(NSMutableDictionary*)ReadAllPeoples;
//+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;
+ (NSString *) phonetic:(NSString*)sourceString;

/**md5加密**/
+(NSString *)md5:(NSString *)str;
/**判断手机格式**/
+(BOOL)isMobileNumber:(NSString *)mobileNum;
@end
