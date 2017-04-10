//
//  CKShareViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKShareViewController.h"
#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>

@interface CKShareViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *myWebView;

@property (nonatomic, strong) ShareView *shareView;

@end

@implementation CKShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    self.topTitle = @"分享有礼";
    
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64)];
    _myWebView.delegate = self;
    [_myWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.xiaomachuxing.com/Xm/qrcode/phpqrcode/id/%@", [MyHelperNO getUid]]]]];
    [self.view addSubview:_myWebView];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    
    NSURL *myUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.xiaomachuxing.com/Xm/qrcode/phpqrcode/id/%@#app", [MyHelperNO getUid]]];
    
    if ([url isEqual:myUrl])
    {
        [self presentShareWaysView];
        return NO;
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('share_tip hide')[0].remove()"];
    [_myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('filter hide')[0].remove()"];
    [_myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('btn')[0].remove()"];
    [_myWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('btn')[0].remove()"];
}



-(void)presentShareWaysView
{
    _shareView = [[ShareView alloc] init];
    _shareView.shareBlock = ^(NSInteger flag){
        [self shareWebPageToPlatformType:flag];
    };
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"http://m.xiaomachuxing.com";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用 小马出行" descr:@"欢迎使用 小马出行 优惠 便捷 一键即达！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://m.xiaomachuxing.com";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
