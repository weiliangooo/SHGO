//
//  PayViewController.m
//  RentOutProject
//
//  Created by Alen on 16/8/18.
//  Copyright © 2016年 Abel. All rights reserved.
//

#import "PayViewController.h"

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




#pragma --mark 支付宝支付


-(void)zhifubaoInit:(id)responseObject
{
    NSDictionary *dic = [responseObject objectForKey:@"data"];
    NSLog(@"0----%@",dic);
    NSDictionary *iosDic = [[dic objectForKey:@"payinfo"] objectForKey:@"ios"];
    NSLog(@"--++++++%@",iosDic);
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.inputCharset = [iosDic stringForKey:@"_input_charset"];
    order.body = [iosDic stringForKey:@"body"];//商品描述
    order.itBPay = [iosDic stringForKey:@"it_b_pay"];
    order.notifyURL = [iosDic stringForKey:@"notify_url"];; //回调URL
    order.outTradeNO = [iosDic stringForKey:@"out_trade_no"]; //订单ID（由商家自行制定）
    order.partner = [iosDic stringForKey:@"partner"];
    order.paymentType = [iosDic stringForKey:@"payment_type"];
    order.sellerID = [iosDic stringForKey:@"seller_id"];
    order.service = [iosDic stringForKey:@"service"];//接口名称
    order.subject = [iosDic stringForKey:@"subject"]; //商品标题
    order.totalFee = [iosDic stringForKey:@"total_fee"]; //商品价格
//    order.totalFee = [dic stringForKey:@"money"]; //商品价格
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"RentOutProjectZ";
//    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
////    NSLog(@"orderSpec = %@",orderSpec);
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = [iosDic stringForKey:@"sign"];
    
   
    
//    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)signedString, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        NSLog(@"orderString == %@",orderString);
//    NSString *orderString = [[dic objectForKey:@"payinfo"] objectForKey:@"java"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }

}

//NSString *signedStr =@"MIICXAIBAAKBgQCko4vj2G/bz7Tutpb1rC0lAyKRG7Z8xtMkbNuhkst8L2HxNlA34TizDq0F8ATHIaEe7/E5a8UHhuMgfhwzdgO0ngT8i2agH9l9Q+MD3WC9bwqXaTpIPCU13GD4QwAmdzW+96kgJwJMzn/ByA+pskF1px8SQKJZvJBWfEZ9X9VIXQIDAQABAoGAeClFeE4Hlg7Kp09sbnHzoQfgurfXQMp8YCFzS0GwcjrC6SIS+jXPBCC595NuaUgKKGJHVPlrHEs+igCA5K5FlOnHVHMyDgbzYKlTkjA/no4zgOvAqktCq+sbo9jcMcCn2TJ4tQt6JmddUS7T8fozRCEHIa+/RUlmzDyzi5TyPQECQQDUTTMlRiyIAIaQFX61x8P6szLdlaiRY7df/Iro4t0yyIVTlkqdNkaDfLMst60E1Q1doFyUe301MjLXc53ZADG5AkEAxobbXkyhs3/dVG2BtXtaD2lsV5HWc372K4OlX+/t9N1v9nE/Rc8C/PAAMsIf99p0bItTdRWqQjJ6oNfLqD2txQJAZlLLGuUGo4o1UQ67Ipwkzhk+o+P0+hYolN/gh7yIRmi1MgNW9Qzq0YbxyNTCVHjnVz/qPzqBr3kBXiyAYM2iKQJBALje+kc9K1OBXbVyaFh87uftL2P4vfA9qbXp2MWXI0tkLhAbc2Vpmgm64SRjW+ut9b7im6wrqaoNYd6INfGMxlUCQBjcOTP0HE4vVczH7S1aFtezoIYy7mhhhPKuml77hGBChy0WOyhutlKS5DoLazbipVvEtKT4Uhw95kIBd5smfIY=";
//
//NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)signedStr, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );

#pragma --mark 微信支付

-(void)weinxinInit:(id)responseObject
{
     NSDictionary *dic = [[responseObject objectForKey:@"data"] objectForKey:@"payinfo"];
    
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
        if(dict != nil)
        {
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                //                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                //                req.partnerId           = [dict objectForKey:@"partnerid"];
                //                req.prepayId            = [dict objectForKey:@"prepayid"];
                //                req.nonceStr            = [dict objectForKey:@"noncestr"];
                //                req.timeStamp           = stamp.intValue;
                //                req.package             = [dict objectForKey:@"package"];
                //                req.sign                = [dict objectForKey:@"sign"];
                req.partnerId = [dic stringForKey:@"partnerid"];
                req.prepayId = [dic stringForKey:@"prepayid"];
                req.package = [dic stringForKey:@"package"];
                req.nonceStr = [dic stringForKey:@"noncestr"];
                req.timeStamp = [dic intForKey:@"timestamp"];
                req.sign = [dic stringForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                //                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\npackage=%@\nnoncestr=%@\ntimestamp=%ld\nsign=%@",@"wxe763c87543526e0b",req.partnerId,req.prepayId,req.package,req.nonceStr,(long)req.timeStamp,req.sign );
//                return @"";
            }
//            else{
//                return [dict objectForKey:@"retmsg"];
//            }
//        }else{
//            return @"服务器返回错误，未获取到json对象";
        }
//    }else{
//        return @"服务器返回错误";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
