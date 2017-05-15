//
//  MyHelperNO.m
//  GoodWallet
//
//  Created by Alen on 2017/1/3.
//  Copyright © 2017年 Abel. All rights reserved.
//

#import "MyHelperNO.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

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


+(NSString *)getMyHeadImage
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"headImage"];
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

//获取ip地址
+ (NSString *)getIpAddresses{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
//    return [address UTF8String];
    return address;
}


@end
