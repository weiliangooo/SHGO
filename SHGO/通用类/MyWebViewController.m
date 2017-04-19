//
//  MyWebViewController.m
//  SHGO
//
//  Created by Alen on 2017/4/19.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "MyWebViewController.h"

@interface MyWebViewController ()

@property (nonatomic, strong) UIWebView *myWebView;

@property (nonatomic, strong) NSString *webTitle;

@property (nonatomic, strong) NSString *webUrl;

@end

@implementation MyWebViewController

-(instancetype)initWithTopTitle:(NSString *)webTitle urlString:(NSString *)urlString
{
    if (self = [super init])
    {
        _webTitle = webTitle;
        _webUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topTitle = _webTitle;
    
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, AL_DEVICE_WIDTH, AL_DEVICE_HEIGHT-64)];
    NSURL *url = [NSURL URLWithString:_webUrl];
    _myWebView.scalesPageToFit = YES;
//    webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_myWebView loadRequest:request];
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
