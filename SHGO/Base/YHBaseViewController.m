 //
//  BaseViewController.m
//  benben
//
//  Created by xunao on 15-2-27.
//  Copyright (c) 2015年 xunao. All rights reserved.
//

#import "YHBaseViewController.h"
#import "CKLoginViewController.h"
#import "AppDelegate.h"
#import "BaseNavViewController.h"
@interface YHBaseViewController ()<UIAlertViewDelegate>{
    MBProgressHUD *_HUD;
    UIView *_topBg;
    MBProgressHUD *toastHUD;
    UIAlertView *phoneAlertView;
    int  boolStlye;
}

@end

@implementation YHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTitle = @"";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUpForDismissKeyboard];
}
/**
 1只有返回按钮
 2返回按钮和搜索按钮
 **/
-(void)setType:(int)type{
    if(type==1)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 38*PROPORTION750, 30*PROPORTION750);
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20*PROPORTION750, 0, 0);
        [_leftBtn setImage:[UIImage imageNamed:@"rowback"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7LeftBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_leftBtn]];
    }
    else if (type==2)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 25*PROPORTION, 25*PROPORTION);
        [_leftBtn setImage:[UIImage imageNamed:@"useravatar"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7LeftBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_leftBtn]];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(0, 0, 25*PROPORTION, 25*PROPORTION);
        [_rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setImage:[UIImage imageNamed:@"messagenotification"] forState:UIControlStateNormal];
        [self ios7RightBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_rightBtn]];
        
    }
    else if(type == 3)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 25*PROPORTION, 25*PROPORTION);
        [_leftBtn setImage:[UIImage imageNamed:@"rowBack"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7LeftBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_leftBtn]];
    
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(0, 0, 60*PROPORTION, 20);
        [_rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14*PROPORTION];
        [_rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7RightBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_rightBtn]];
    }
    else if(type == 4)
    {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(0, 0, 60*PROPORTION, 20);
        [_rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14*PROPORTION];
        [_rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7RightBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_rightBtn]];
    }
    else if(type == 5)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 60*PROPORTION, 25*PROPORTION);
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = SYSF750(25);
//        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15*PROPORTION750, 0, 0);
        [_leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7LeftBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_leftBtn]];
    }
    else if (type == 6)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 60*PROPORTION, 25*PROPORTION);
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = SYSF750(25);
        //        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15*PROPORTION750, 0, 0);
        [_leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7LeftBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_leftBtn]];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(0, 0, 60*PROPORTION, 25*PROPORTION);
        [_rightBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _rightBtn.titleLabel.font = SYSF750(25);
        [_rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ios7RightBarButtonItems:[[UIBarButtonItem alloc]initWithCustomView:_rightBtn]];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTranslucent:false];
//    for (UIView *view in [self.tabBarController.tabBar subviews]) {
//        if ([view isKindOfClass:[UIControl class]]) {
//            [view removeFromSuperview];
//        }
//        if ([view isKindOfClass:[UIImageView class]]) {
//            [view removeFromSuperview];
//        }
//    }
    
//    [self setUpForDismissKeyboard];
}

-(void)leftBtn:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
   
}
-(void)rightBtn:(UIButton *)button{

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)ios7RightBarButtonItems:(UIBarButtonItem *)baritem
{
    if(IS_IOS7){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, baritem];
    }else {
        self.navigationItem.rightBarButtonItem = baritem;
    }
}
-(void)ios7LeftBarButtonItems:(UIBarButtonItem *)baritem
{
    if(IS_IOS7){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, baritem];
    }else {
        self.navigationItem.leftBarButtonItem = baritem;
    }
}


- (void)isLoginWith:(BaseNavViewController *)vc {
    NSMutableDictionary *parm = [NSMutableDictionary new];
    if (![USERDEFAULTS stringForKey:@"token"]) {
        [self backToLoginVC];
    }else{
        [parm setObject:[USERDEFAULTS stringForKey:@"token"] forKey:@"token"];
        
        [self postback:@"user/validate-token" withParam:parm success:^(id responseObject) {
            NSInteger code = [responseObject integerForKey:@"code"];
            if (code == 200) {
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self backToLoginVC];
            }
        } failure:nil];
    }
}
- (BOOL)isTimeoutWithToken {
    
    NSString *token=[USERDEFAULTS objectForKey:@"token"];
//    if (!token||token.length == 0) {
//        NSLog(@"aaa");
//        return NO;
//    }
    NSMutableDictionary *parm = [NSMutableDictionary new];
    [parm setObject:token forKey:@"token"];
    [self post:@"user/validate-token" withParam:parm success:^(id responseObject) {
        NSInteger code = [responseObject integerForKey:@"code"];
        if (code == 200) {
            boolStlye = 1;
        }else{
            boolStlye = 0;
        }
    } failure:nil];
    if (boolStlye == 1) {
        return NO;
    }else{
        return YES;
    }
}
-(void)setTopTitle:(NSString *)string{
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, 44)];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setText:string];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [title setFont:[UIFont boldSystemFontOfSize:16*PROPORTION]];
    [title sizeToFit];
    [self.navigationItem setTitleView:title];
}
-(void)setNavTitle:(NSString *)string{
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, 44)];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setText:string];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor whiteColor]];
    [title setFont:[UIFont boldSystemFontOfSize:16*PROPORTION]];
    [title sizeToFit];
    [self.navigationItem setTitleView:title];
}
-(BOOL)shouldAutorotate{
    return NO;
}

/**nav-end**/
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
-(void)postInbackground:(NSString *)api withParam:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *error))failure
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
            [self alertMessage:@"接口请求失败"];
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
    NSLog(@"--%@",urlString);
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
            [self alertMessage:@"网络不可用！"];
        }else {
            NSString *msg = [[error userInfo] objectForKey:@"des"];
            if (msg) {
                [self alertMessage:msg];
            }else {
//                [self alertMessage:@"当前无可用网络"];
            }
        }
}


-(void)showLoading:(NSString*)text
{
    UIWindow *_keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!_keyWindow) {
        _keyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    _HUD = [MBProgressHUD showHUDAddedTo:_keyWindow animated:YES];
    [_HUD setBackgroundColor:[UIColor clearColor]];
    [_HUD setDimBackground:NO];
    _HUD.delegate = self;
    [_HUD setLabelText:text];
    [_HUD setHidden:NO];
    CGAffineTransform at =CGAffineTransformMakeRotation(2*M_PI);
    [_HUD setTransform:at];
    [_keyWindow bringSubviewToFront:_HUD];
}

-(void)hideLoading
{
    [_HUD setHidden:YES];
}
//

- (void)alertMessage:(NSString *)message
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}
- (void)phoneAlertView:(NSString *)number {
    phoneAlertView = [[UIAlertView alloc]initWithTitle:number message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"呼叫", nil];
    phoneAlertView.tag = 200;
    [phoneAlertView show];
}


- (void)phoneAlertView:(NSString *)number :(NSString *)title
{
    phoneAlertView = [[UIAlertView alloc]initWithTitle:number message:@"（按3号键转接）" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"呼叫", nil];
    phoneAlertView.tag = 200;
    [phoneAlertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == phoneAlertView) {
        if (buttonIndex == 1) {
            if (IS_IOS8) {
                BOOL result = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneAlertView.title]]];
                if (!result) {
//                    [self alertMessage:@"拨号失败,请检查号码是否正确"];
                    return;
                }
                
            }else{
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneAlertView.title];
                UIWebView * callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
            }
        }else{
//            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
}

//消除多余的线
- (void) makeExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    [tableView setTableFooterView:view];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



//弹出提示
-(void)alert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
//toast
-(void)toast:(NSString*)str{
    toastHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:toastHUD];
    toastHUD.labelText = str;
    toastHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    [toastHUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [toastHUD removeFromSuperview];
        toastHUD = nil;
    }];
}

-(void)backToLastVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoLoginViewController
{
    CKLoginViewController *viewController = [[CKLoginViewController alloc] init];
    BaseNavViewController *navigationController = [[BaseNavViewController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
