//
//  MyHelperNO.m
//  GoodWallet
//
//  Created by Alen on 2017/1/3.
//  Copyright © 2017年 Abel. All rights reserved.
//

#import "MyHelperNO.h"

@implementation MyHelperNO


+(MyHelperNO *)shareInstance
{
    static MyHelperNO *sharedMyHelperNOInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMyHelperNOInstance = [[self alloc] init];
    });
    return sharedMyHelperNOInstance;
}

+(BOOL)isFirstLogin
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hadLogin"] == nil || [[NSUserDefaults standardUserDefaults] boolForKey:@"hadLogin"] == NO)
    {
        return YES;
    }
    return NO;
}


+(NSString *)getMyToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
}

+(BOOL)isHadAuthentication
{
    return YES;
}

+(NSString *)getUid
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
}


+(NSString *)getMyUsername
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
}

+(NSString *)getMyMobilePhone
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"mobilePhone"];
}

+(NSString *)getMyIdentNo
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"identNo"];
}

+(NSString *)getMyRealName
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"realName"];
}





+(void)removeAllData
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary* dict = [defs dictionaryRepresentation];
    
    for(id key in dict) {
        
        if (![key isEqualToString:@"hadLogin"])
        {
            [defs removeObjectForKey:key];
        }
    }
    
    [defs synchronize];
}


@end
