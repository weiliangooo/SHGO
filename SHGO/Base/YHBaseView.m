//
//  YHBaseView.m
//  Fram
//
//  Created by yangH4 on 16/2/17.
//  Copyright © 2016年 yangH4. All rights reserved.
//

#import "YHBaseView.h"
#import "XAClient.h"

@interface YHBaseView ()<UIAlertViewDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *_HUD;
    MBProgressHUD *toastHUD;
}
@end
@implementation YHBaseView

-(id)init{
    self =[super init];
    if (self) {
        [self setUpForDismissKeyboard];
    }
    return self;
}
#pragma mark-Http请求
//单例无loadingPOST
-(void)postback:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] POST:urlString withParam:params success:^(id responseObject) {
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
            [self handdleRequestError:error];
            if (failure != nil) {
                failure(error);
            }
        }
    }];
}

//单例有loadingPOST
-(void)post:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self showLoading:@"正在加载..."];
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] POST:urlString withParam:params success:^(id responseObject) {
        [self hideLoading];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (success != nil) {
                success(responseObject);
            }
        }else {
            
        }
    } failure:^(NSError *error) {
        [self hideLoading];
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else {
            NSLog(@"请求失败---%@",error);
            [self handdleRequestError:error];
            if (failure != nil) {
                failure(error);
            }
        }
    }];
}



//多例POST
-(void)postInbackground:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] postInBackground:urlString withParam:params success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (success != nil) {
                success(responseObject);
            }
        }
    } failure:nil];
}


//单例有loadingGET
-(void)get:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self showLoading:@"正在加载..."];
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] GET:urlString withParam:params success:^(id responseObject) {
        [self hideLoading];
        if (success != nil) {
            
            success(responseObject);
            
        }else {
            [self toast:@"接口请求失败"];
        }
    } failure:^(NSError *error) {
        [self hideLoading];
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else {
            NSLog(@"请求失败---%@",error);
            [self handdleRequestError:error];
            if (failure != nil) {
                failure(error);
            }
        }
    }];
}

//单例无loadingGET
-(void)getNoLoading:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] GET:urlString withParam:params success:^(id responseObject) {
        if (success != nil) {
            
            success(responseObject);
        }else {
            NSLog(@"接口请求失败");
            //            [self alertMessage:@"接口请求失败"];
        }
    } failure:^(NSError *error) {
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else {
            NSLog(@"请求失败---%@",error);
            [self handdleRequestError:error];
            if (failure != nil) {
                failure(error);
                NSLog(@"服务器无响应,请稍后再试");
                //                [self alertMessage:@"服务器无响应,请稍后再试"];
            }
        }
    }];
}
//多例无loadingGET
-(void)getback:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] backgroundGET:urlString withParam:params success:^(id responseObject) {
        if (success != nil) {
            
            success(responseObject);
        }else {
            
        }
    } failure:^(NSError *error) {
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else {
            NSLog(@"请求失败---%@",error);
            [self handdleRequestError:error];
            if (failure != nil) {
                failure(error);
            }
        }
    }];
}
//单例有loadingPUT
-(void)put:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self showLoading:@"正在加载..."];
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] PUT:urlString withParam:params success:^(id responseObject) {
        [self hideLoading];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (success != nil) {
                success(responseObject);
            }
        }else {
            
        }
        
    } failure:^(NSError *error) {
        [self hideLoading];
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else {
            NSLog(@"请求失败---%@",error);
            [self handdleRequestError:error];
            if (failure != nil) {
                failure(error);
            }
        }
    }];
}

-(void)DELECT:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self showLoading:@"正在加载..."];
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] DELECT:urlString withParam:params success:^(id responseObject) {
        [self hideLoading];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (success != nil) {
                success(responseObject);
            }
        }else {
            
        }
        
    } failure:^(NSError *error) {
        [self hideLoading];
        if (error.code == NSURLErrorCancelled) {
            NSLog(@"请求被取消");
        }else {
            NSLog(@"请求失败---%@",error);
            [self handdleRequestError:error];
            if (failure != nil) {
                failure(error);
            }
        }
    }];
}
//上传带附件
-(void)POSTMultipartForm:(NSString *)api param:(NSMutableDictionary *)param files:(NSArray *)filesArray completion:(void (^)(id, NSError *))completion progress:(void (^)(float))progress
{
    [self showLoading:@"正在加载..."];
    NSString *urlString = [YH_REQUEST_DOMAIN stringByAppendingString:api];
    [[XAClient sharedClient] POSTMultipartForm:urlString param:param files:filesArray completion:^(id responseObject, NSError *error) {
        if (completion) {
            
            completion(responseObject, error);
        }
        [self hideLoading];
    } progress:progress];
}
-(void)handdleRequestError:(NSError *)error
{
    if (error.code == 10086) {
        [self toast:@"网络不可用！"];
    }else {
        NSString *msg = [[error userInfo] objectForKey:@"des"];
        if (msg) {
            [self toast:msg];
        }else {
            //                [self alertMessage:@"当前无可用网络"];
        }
    }
}

-(void)showLoading:(NSString*)text
{
    _HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [_HUD setBackgroundColor:[UIColor clearColor]];
    [_HUD setDimBackground:NO];
    _HUD.delegate = self;
    [_HUD setLabelText:text];
    [_HUD setHidden:NO];
    [self bringSubviewToFront:_HUD];
    CGAffineTransform at =CGAffineTransformMakeRotation(2*M_PI);
    [toastHUD setTransform:at];
}
-(void)hideLoading
{
    [_HUD setHidden:YES];
}
//toast
-(void)toast:(NSString*)str{
    toastHUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:toastHUD];
    toastHUD.labelText = str;
    toastHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    [toastHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [toastHUD removeFromSuperview];
        toastHUD = nil;
    }];
    CGAffineTransform at =CGAffineTransformMakeRotation(2*M_PI);
    [toastHUD setTransform:at];
}

//点击屏幕键盘消失
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self removeGestureRecognizer:singleTapGR];
                }];
}

//弹出提示
-(void)alert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
