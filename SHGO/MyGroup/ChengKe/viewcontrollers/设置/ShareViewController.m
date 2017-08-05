//
//  CKShareViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/10.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "ShareViewController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface ShareViewController (){
    NSString *shareTitle;
    NSString *shareUrl;
    NSString *shareContent;
}

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, AL_DEVICE_HEIGHT-390*PROPORTION750, AL_DEVICE_WIDTH, 390*PROPORTION750)];
    myView.tag = 1000;
    myView.userInteractionEnabled = YES;
//    [myView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
    myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myView];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
    [closeBtn setImage:[UIImage imageNamed:@"pay_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismissCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:closeBtn];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, 630*PROPORTION750, 30*PROPORTION750)];
    titleLB.text = @"分享到";
    titleLB.font = SYSF750(30);
    titleLB.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:titleLB];
    
    NSArray *images = @[@"wchat_share",@"session_share",@"qq_share",@"qqzone_share"];
    NSArray *tips = @[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间"];
    for (int i = 0; i < 4; i++){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60*PROPORTION750+175*PROPORTION750*i, 90*PROPORTION750, 105*PROPORTION750, 160*PROPORTION750)];
        view.tag = 100+i;
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
        [myView addSubview:view];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.width, view.width)];
        image.clipsToBounds = YES;
        image.layer.cornerRadius = 52.5*PROPORTION750;
        image.image = [UIImage imageNamed:images[i]];
        [view addSubview:image];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 135*PROPORTION750, 105*PROPORTION750, 25*PROPORTION750)];
        label.text = tips[i];
        label.font = SYSF750(25);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20*PROPORTION750, myView.height-110*PROPORTION750, 710*PROPORTION750, 90*PROPORTION750)];
    button.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 15*PROPORTION750;
    [button setTitle:@"取消分享" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = SYSF750(40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(dismissCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:button];
    
    [self loadData];
}

-(void)loadData{
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token",nil];
    [self postInbackground:@"index/title" withParam:reqDic success:^(id responseObject) {
        int code = [responseObject intForKey:@"status"];
        NSString *msg = [responseObject stringForKey:@"msg"];
        NSLog(@"%@", responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (code == 200){
                NSDictionary *data = [responseObject objectForKey:@"data"];
                shareTitle = [data stringForKey:@"titile"];
                shareUrl = [data stringForKey:@"url"];
                shareContent = [data stringForKey:@"des"];
            }
            else if (code == 300){
                [self toast:@"身份认证已过期"];
                [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
            }
            else if (code == 400){
                [self toast:msg];
            }
        });
    } failure:^(NSError *error) {
        
    }];

}

-(void)dismissCurrentView{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)viewTapEvents:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
        case 100:{
            [self shareWebPageToPlatformType:1];
        }
            break;
        case 101:{
            [self shareWebPageToPlatformType:2];
        }
            break;
        case 102:{
            [self shareWebPageToPlatformType:4];
        }
            break;
        case 103:{
            [self shareWebPageToPlatformType:5];
        }
            break;
        default:
            break;
    }
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    if (shareTitle == nil) {
        shareTitle = @"Hi，朋友，送你10元小马出行优惠券，为你约车买单！";
        shareUrl = [NSString stringWithFormat:@"https://m.xiaomachuxing.com/qrcode/inviteapp/id/%@", [MyHelperNO getUid]];
        shareContent = @"我一直用小马出行，既经济又便捷舒适，邀你一起来体验，首次乘坐立减10元~";
    }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareContent thumImage:[UIImage imageNamed:@"default"]];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
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

@end
