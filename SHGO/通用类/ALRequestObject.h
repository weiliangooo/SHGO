//
//  ALRequestObject.h
//  SHGO
//
//  Created by 魏亮 on 2017/6/13.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAClient.h"

@interface ALRequestObject : XAClient

+(ALRequestObject *)shareInstance;

+(void)put:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
