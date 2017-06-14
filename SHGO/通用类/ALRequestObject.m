//
//  ALRequestObject.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/13.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ALRequestObject.h"
#import "XAClient.h"

@implementation ALRequestObject

+(ALRequestObject *)shareInstance{
    static ALRequestObject *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+(void)put:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] PUT:urlString withParam:params success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (success != nil) {
                success(responseObject);
            }
        }else {
            
        }
        
    } failure:^(NSError *error) {
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else {
            NSLog(@"请求失败---%@",error);
            if (failure != nil) {
                failure(error);
            }
        }
    }];
}



@end
