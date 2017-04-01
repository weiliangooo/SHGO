//
//  YHBaseView.h
//  Fram
//
//  Created by yangH4 on 16/2/17.
//  Copyright © 2016年 yangH4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBaseView : UIView

/**网络**/

//弹出提示
-(void)alert:(NSString *)message;

-(void)toast:(NSString*)str;
/**单例有loadingPOST*/
-(void)post:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**单例无loadingPOST*/
-(void)postback:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**多例POST*/
-(void)postInbackground:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

/**单例有loadingGET*/
-(void)get:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

/**单例无loadingGET*/
-(void)getNoLoading:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;

/**多例无loadingGET*/
-(void)getback:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**PUT*/
-(void)put:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;
/**DELECT*/
-(void)DELECT:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**上传带附件**/
-(void)POSTMultipartForm:(NSString *)api param:(NSMutableDictionary *)param files:(NSArray *)filesArray completion:(void (^)(id, NSError *))completion progress:(void (^)(float))progress;

@end
