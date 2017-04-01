//
//  XAClient.h
//  NetWork
//
//  Created by xunao on 15-2-9.
//  Copyright (c) 2015年 xunao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFDownloadRequestOperation.h"

@interface XAClient : NSObject

@property (nonatomic) BOOL isNetWorkAvailable;
@property (nonatomic) BOOL isNetWorkEnable;
@property (nonatomic) AFHTTPRequestOperationManager *httpManager;

@property (nonatomic) AFHTTPRequestOperation *downloadOperation;

+(XAClient *) sharedClient;

/**
 单例请求接口POST
 */
-(BOOL)POST:(NSString *)apiUrl withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;


-(BOOL)POSTMultipartForm:(NSString *)api param:(NSMutableDictionary *)param files:(NSArray *)filesArray completion:(void (^)(id, NSError *))completion progress:(void (^)(float))progress;
/**
 多例请求接口POST
 */
-(BOOL)postInBackground:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**
 单例请求接口GET
 */
-(BOOL)GET:(NSString *)apiUrl withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**
 多例请求接口GET
 */
-(BOOL)backgroundGET:(NSString *)apiUrl withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

-(BOOL)PUT:(NSString *)apiUrl withParam:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

-(BOOL)DELECT:(NSString *)apiUrl withParam:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

///单例下载
-(void)Download:(NSString *)urlString
  progressBlock:(void (^)(AFDownloadRequestOperation *, NSInteger, long long, long long, long long, long long))progressBlock
        success:(void (^)(AFHTTPRequestOperation *, id))success
        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
///取消下载
-(void)cancelDownloading;

-(BOOL)POSTJSON:(NSString *)apiUrl withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;


@end
