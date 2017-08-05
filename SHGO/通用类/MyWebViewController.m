//
//  MyWebViewController.m
//  SHGO
//
//  Created by Alen on 2017/4/19.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "MyWebViewController.h"

#import "UIImage+ScalImage.h"

#import <UMSocialCore/UMSocialCore.h>

#import "ShareViewController.h"

@interface MyWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *myWebView;

@property (nonatomic, strong) NSString *webTitle;

@property (nonatomic, strong) NSString *webUrl;

@end

@implementation MyWebViewController

-(instancetype)initWithTopTitle:(NSString *)webTitle urlString:(NSString *)urlString
{
    if (self = [super init]){
        _webTitle = webTitle;
        _webUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 1;
    
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64)];
    _myWebView.delegate = self;
    if (_webUrl == nil) {
        _webUrl = [NSString stringWithFormat:@"https://m.xiaomachuxing.com/qrcode/recommendapp/id/%@", [MyHelperNO getUid]];
    }
    NSURL *url = [NSURL URLWithString:_webUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_myWebView loadRequest:request];
    
    _myWebView.scalesPageToFit = YES;
    [self.view addSubview:_myWebView];
}

-(void)leftBtn:(UIButton *)button{
    if ([_myWebView canGoBack]) {
        [_myWebView goBack];
    }else{
        if (self.navigationController.viewControllers.count == 1) {
            [self dismissViewControllerAnimated:true completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = [request URL].absoluteString;
//    NSURL *myUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@#", _webUrl]];
    if ([[url substringFromIndex:url.length-1] isEqual:@"#"]){
        [self presentShareWaysView];
        return NO;
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_webTitle == nil) {
        _webTitle = [_myWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    self.topTitle = _webTitle;
}

-(void)presentShareWaysView{
    ShareViewController *viewContrller = [[ShareViewController alloc] init];
    viewContrller.modalPresentationStyle = UIModalPresentationCustom;
    viewContrller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewContrller animated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
