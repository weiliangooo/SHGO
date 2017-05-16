//
//  PayViewController.m
//  RentOutProject
//
//  Created by Alen on 16/8/18.
//  Copyright © 2016年 Abel. All rights reserved.
//

#import "PayViewController.h"
#import "DataSigner.h"


//支付宝配置
//支付宝私钥，自助生成
#define PartnerPrivKey @"MIICXQIBAAKBgQC5LMfCMEfnVNrpV/kylM6F43BS/c8T8e2Yqkgbufo8rf+kq/7z/POPkUTsKMkdHQwX5OYtFGVsoGESHlE+lbOfeOwYkuP+tFJMEQqbbYPF0gVeDJ7BAPxcGNQgWVcCZozKTsioBAE/tDikVH1RG87JNWD6l/FpuCDXe25/AZE/7QIDAQABAoGAcfDyAbU/qUJ3aTmupscVxSDLzuVJ9FXbAyNUN2taZNgUA7mpqWwuWlri9AWsqnNjK5i3YWm5dvvAfyuUhlQLL7p8V7fhGQNKhnJ79D2Chu4VpyqNO+TjnqXj06B2+iQGxRDKe3pqN061+eJrm3z5kD1JD1qxp9AZTAlqGCnXpCkCQQDths3utQyDSaSn7VosfZ4Q3gUDyb9RZTaEmskwSLuyRlAR5FR9XiPjxiU92C9458TImSr4M1UvMIynD6TRD0hfAkEAx5OlMQiPDftMgoE5BHGt6i9m8tbRwXhflG/TBps0KTEaMQLFVPUkhKdPaRY4S8JuTvx43sY6aQM1kjIGB+5LMwJAS0x47DupA9XMxQ+RjpkkCuTXYiQK6prTdaY8MXpdRl7T81gXEMdPSV3/YGOwaPvQfmdQH+7mClexvyROc5gMsQJBAL4tETKiRz85gfSyEpULhoAr31v0HDjR7bJSxLH83z2JTr35N/T3DG9jxyYKSGbYxah6qOsP1cUPi9Ld3CVei0UCQQCpL42uX/VU1yFAKkGv0WkjzKoi+dPpBnvqKkoJolDCCfSfejaa2YXykGPiRk36ib5AxVB27lcImLLYiPzr7Jx0"


@interface PayViewController ()
{
    NSString *_paysn;
}

@end

@implementation PayViewController


+(PayViewController *)shareManager;
{
    static PayViewController *sharedLocationPlaceInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLocationPlaceInstance = [[self alloc] init];
    });
    return sharedLocationPlaceInstance;
}

#pragma --mark 支付宝测试
-(void)zhifubaoInit
{
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [Order new];
    order.app_id = @"2017050207083432"; //appid
    order.method = @"alipay.trade.app.pay";// NOTE: 支付接口名称
    order.charset = @"utf-8";//商户网站使用的编码格式，固定为utf-8。
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];// NOTE: 当前时间点
    order.version = @"1.0";// NOTE: 支付版本
    order.sign_type = @"RSA";// NOTE: sign_type设置
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"出行付费";
    order.biz_content.subject = @"小马出行";
    order.biz_content.out_trade_no = @"20179090239049"; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"15m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"haomaxmcx";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}


#pragma --mark 支付宝支付
-(void)zhifubaoInit:(id)responseObject
{
    NSDictionary *data = [responseObject objectForKey:@"data"];
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [Order new];
    order.app_id = @"2017050207083432"; //appid
    order.method = @"alipay.trade.app.pay";// NOTE: 支付接口名称
    order.charset = [data stringForKey:@"_input_charset"];//商户网站使用的编码格式，固定为utf-8。
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];// NOTE: 当前时间点
    order.version = @"1.0";// NOTE: 支付版本
    order.sign_type = @"RSA";// NOTE: sign_type设置
    
    order.notify_url = [data stringForKey:@"notify_url"];
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = [data stringForKey:@"body"];
    order.biz_content.subject = [data stringForKey:@"subject"];
    order.biz_content.out_trade_no = [data stringForKey:@"out_trade_no"]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"15m"/*[data stringForKey:@"it_b_pay"]*/; //超时时间设置
//    order.biz_content.total_amount = [NSString stringWithFormat:@"%@", [data stringForKey:@"total_fee"]]; //商品价格
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01];
    order.biz_content.seller_id = [data stringForKey:@"seller_id"];
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"haomaxmcx";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

#pragma --mark 微信支付
-(void)weinxinInit:(id)responseObject
{
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil)
    {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"url:%@",urlString);
    }
    
    NSDictionary *dic = [responseObject objectForKey:@"data"];
    if (![WXApi isWXAppInstalled])
    {
        NSLog(@"未安装微信");
        return ;
    }
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        NSLog(@"未安装微信");
        return ;
    }
    
    else if (![WXApi isWXAppSupportApi])
    {
        NSLog(@"不支持微信支付");
        return ;
    }

        if(dic != nil){
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId = [dic stringForKey:@"partnerid"];
            req.prepayId = [dic stringForKey:@"prepayid"];
            req.package = @"Sign=WXPay";
            req.nonceStr = [dic stringForKey:@"noncestr"];
            req.timeStamp = [[dic stringForKey:@"timestamp"] doubleValue];
            req.sign = [dic stringForKey:@"sign"];
            [WXApi sendReq:req];
        }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
