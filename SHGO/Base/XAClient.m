//
//  XAClient.m
//  NetWork
//
//  Created by xunao on 15-2-9.
//  Copyright (c) 2015年 xunao. All rights reserved.
//

#import "XAClient.h"
#import "Reachability.h"
#import "UploadFileData.h"
#import "Frame.h"

@implementation XAClient
+(XAClient *)sharedClient
{
    static XAClient *_sharedClient;
    if (_sharedClient == nil) {
        _sharedClient = [[XAClient alloc] init];
    }
    return _sharedClient;
}

-(BOOL)isNetWorkEnable
{
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    return status != kNotReachable;
}

-(BOOL)isNetWorkAvailable
{
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] != AFNetworkReachabilityStatusNotReachable;
}

-(AFHTTPRequestOperationManager *)httpManager
{
    if (_httpManager == nil) {
        _httpManager = [AFHTTPRequestOperationManager manager];
        _httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    }
    return _httpManager;
}


//POST方式
-(BOOL)POST:(NSString *)apiUrl withParam:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //取消其他所有请求
    [self.httpManager.operationQueue cancelAllOperations];
    //检查网络是否可用
    if (!self.isNetWorkAvailable) {
        if (failure) {
            NSError *error = [[NSError alloc] initWithDomain:@"netWorkError" code:-10086 userInfo:[NSDictionary dictionaryWithObject:@"网络不可用" forKey:@"des"]];
            failure(error);
        }
        return NO;
    }
    NSLog(@"%@%@", apiUrl, [self paramToString:params]);
    //请求接口
    [self.httpManager POST:apiUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else if (failure != nil) {
            failure(error);
        }
    }];
    return YES;
}

//POST方式
-(BOOL)POSTJSON:(NSString *)apiUrl withParam:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //取消其他所有请求
    [httpManager.operationQueue cancelAllOperations];
    //检查网络是否可用
    if (!self.isNetWorkAvailable) {
        if (failure) {
            NSError *error = [[NSError alloc] initWithDomain:@"netWorkError" code:-10086 userInfo:[NSDictionary dictionaryWithObject:@"网络不可用" forKey:@"des"]];
            failure(error);
        }
        return NO;
    }
    NSLog(@"%@%@", apiUrl, [self paramToString:params]);
    //请求接口
    [httpManager POST:apiUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else if (failure != nil) {
            failure(error);
        }
    }];
    return YES;
}


//PUT方式
-(BOOL)PUT:(NSString *)apiUrl withParam:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //取消其他所有请求
    [self.httpManager.operationQueue cancelAllOperations];
    //检查网络是否可用
    if (!self.isNetWorkAvailable) {
        if (failure) {
            NSError *error = [[NSError alloc] initWithDomain:@"netWorkError" code:-10086 userInfo:[NSDictionary dictionaryWithObject:@"网络不可用" forKey:@"des"]];
            failure(error);
        }
        return NO;
    }
    //    NSLog(@"%@%@", apiUrl, [self paramToString:params]);
    //请求接口
    [self.httpManager PUT:apiUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else if (failure != nil) {
            failure(error);
        }
    }];
    return YES;
}
//DELETE方式
-(BOOL)DELECT:(NSString *)apiUrl withParam:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //取消其他所有请求
    [self.httpManager.operationQueue cancelAllOperations];
    //检查网络是否可用
    if (!self.isNetWorkAvailable) {
        if (failure) {
            NSError *error = [[NSError alloc] initWithDomain:@"netWorkError" code:-10086 userInfo:[NSDictionary dictionaryWithObject:@"网络不可用" forKey:@"des"]];
            failure(error);
        }
        return NO;
    }
    //    NSLog(@"%@%@", apiUrl, [self paramToString:params]);
    //请求接口
    [self.httpManager DELETE:apiUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else if (failure != nil) {
            failure(error);
        }
    }];
    return YES;
}



-(BOOL)postInBackground:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //取消其他所有请求
    [httpManager.operationQueue cancelAllOperations];
    //检查网络是否可用
    if (!self.isNetWorkAvailable) {
        if (failure) {
            NSError *error = [[NSError alloc] initWithDomain:@"netWorkError" code:-10086 userInfo:[NSDictionary dictionaryWithObject:@"网络不可用" forKey:@"des"]];
            failure(error);
        }
        return NO;
    }
    NSLog(@"%@%@", api, [self paramToString:params]);
    //请求接口 AFN
    [httpManager POST:api parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else if (failure != nil) {
            failure(error);
        }
    }];
    return YES;
}

//GET方式
-(BOOL)GET:(NSString *)apiUrl withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //取消其他所有请求
    [self.httpManager.operationQueue cancelAllOperations];
    //检查网络是否可用
    if (!self.isNetWorkAvailable) {
        if (failure) {
            NSError *error = [[NSError alloc] initWithDomain:@"netWorkError" code:-10086 userInfo:[NSDictionary dictionaryWithObject:@"网络不可用" forKey:@"des"]];
            failure(error);
        }
        return NO;
    }
    NSLog(@"%@%@", apiUrl, [self paramToString:params]);
    //请求接口
    [self.httpManager GET:apiUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else if (failure != nil) {
            failure(error);
        }
    }];
    return YES;
}

-(BOOL)backgroundGET:(NSString *)apiUrl withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //取消其他所有请求
    [httpManager.operationQueue cancelAllOperations];
    //检查网络是否可用
    if (!self.isNetWorkAvailable) {
        if (failure) {
            NSError *error = [[NSError alloc] initWithDomain:@"netWorkError" code:-10086 userInfo:[NSDictionary dictionaryWithObject:@"网络不可用" forKey:@"des"]];
            failure(error);
        }
        return NO;
    }
    NSLog(@"%@%@", apiUrl, [self paramToString:params]);
    //请求接口
    [httpManager GET:apiUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else if (failure != nil) {
            failure(error);
        }
    }];
    return YES;
}
-(BOOL)POSTMultipartForm:(NSString *)api param:(NSMutableDictionary *)param files:(NSArray *)filesArray completion:(void (^)(id, NSError *))completion progress:(void (^)(float))progress
{
    if (param == nil) {
        param = [NSMutableDictionary dictionary];
    }
    NSLog(@"%@%@", api, [self paramToString:param]);
    
    AFHTTPRequestOperation *op = [self.httpManager POST:api parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (filesArray && [filesArray count] > 0) {
            for (UploadFileData *item in filesArray) {
                NSLog(@"%@",item.postName);
                NSLog(@"%@",item.fileName);
                NSLog(@"%@",item.mimeType);
                [formData appendPartWithFileData:item.fileData name:item.postName fileName:item.fileName mimeType:item.mimeType];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
    //有附件时,监听进度
    if (filesArray && [filesArray count] > 0) {
        [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            if (progress) {
                float p = ((float)totalBytesWritten) / (float)totalBytesExpectedToWrite;
                progress(p);
            }
        }];
    }
    return YES;
}



-(NSString *)paramToString:(NSDictionary *)params
{
    __block NSString *paramStr = @"";
    if (params) {
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *object = [NSString stringWithFormat:@"%@", obj];
            NSString *val = [object stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (paramStr.length == 0) {
                paramStr = [NSString stringWithFormat:@"?%@=%@",key, val];
            }else {
                paramStr = [NSString stringWithFormat:@"%@&%@=%@", paramStr,key, val];
            }
        }];
    }
    return paramStr;
}

//取消下载
-(void)cancelDownloading
{
    [self.downloadOperation cancel];
    self.downloadOperation = nil;
}

//下载文件
-(void)Download:(NSString *)urlString
  progressBlock:(void (^)(AFDownloadRequestOperation *, NSInteger, long long, long long, long long, long long))progressBlock
        success:(void (^)(AFHTTPRequestOperation *, id))success
        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    if (urlString && urlString.length>0) {//下载地址不为空
        if ([self isNetWorkAvailable]) {//检查网络
            NSString *downloadPath = [Frame getDownloadPath:urlString];
            //取消下载
            [self cancelDownloading];
            
            NSURL *url = [NSURL URLWithString:urlString];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
            AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:downloadPath shouldResume:YES];
            [operation setShouldOverwrite:YES];
            [operation start];
            
            self.downloadOperation = operation;
            //监控下载
            //下载进度回调
            [operation setProgressiveDownloadProgressBlock:progressBlock];
            //成功和失败回调
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (success) {
                    success(operation, responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@", error);
                if (failure) {
                    failure(operation, error);
                }
            }];
        }
    }else {
        if (failure) {
            failure(nil, nil);
        }
    }
}


@end
