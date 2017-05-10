//
//  CKOrderDetailViewController.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKOrderDetailViewController.h"
#import "OrderDetailView.h"
#import "OrderDetailModel.h"
#import "OrderPriceDetailViewController.h"
#import "OrderPriceModel.h"
#import "ShareView.h"

#import <UMSocialCore/UMSocialCore.h>

@interface CKOrderDetailViewController ()<OrderDetailDelegate>

@property (nonatomic, strong)OrderDetailView *detailView;

@end

@implementation CKOrderDetailViewController

-(instancetype)initWithOrderDetailModel:(OrderDetailModel *)orderDetailModel
{
    if (self = [super init])
    {
        _dataSouce = orderDetailModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 2;
    self.leftBtn.frame = CGRectMake(0, 0, 38*PROPORTION750, 30*PROPORTION750);
    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20*PROPORTION750, 0, 0);
    [self.leftBtn setImage:[UIImage imageNamed:@"rowback"] forState:UIControlStateNormal];
    self.rightBtn.frame = CGRectMake(0, 0, 35*PROPORTION, 35*PROPORTION);
    [self.rightBtn setImage:[UIImage imageNamed:@"regular_wallet"] forState:UIControlStateNormal];
    self.topTitle = _dataSouce.orderStatus;
    self.startAnnotation.subtitle = _dataSouce.startPlace.address;
    self.startAnnotation.coordinate = _dataSouce.startPlace.location;
    self.endAnnotation.subtitle = _dataSouce.endPlace.address;
    self.endAnnotation.coordinate = _dataSouce.endPlace.location;
    [self getMapViewVisbleRect];
    
    _detailView = [[OrderDetailView alloc] initWithFrame:CGRectMake(30*PROPORTION750, AL_DEVICE_HEIGHT-475*PROPORTION750-64, 690*PROPORTION750, 465*PROPORTION750) dataSourece:_dataSouce];
    _detailView.delegate = self;
    [self.view addSubview:_detailView];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(300*PROPORTION750, _detailView.top-45*PROPORTION750, 150*PROPORTION750, 150*PROPORTION750)];
    headImgView.clipsToBounds = YES;
    headImgView.layer.cornerRadius = 75*PROPORTION750;
    headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImgView.layer.borderWidth = 8*PROPORTION750;
    headImgView.image = [UIImage imageNamed:@"default"];
    [self.view addSubview:headImgView];
    
    UILabel *carNumLB = [[UILabel alloc] initWithFrame:CGRectMake(300*PROPORTION750, _detailView.top+85*PROPORTION750, 150*PROPORTION750, 40*PROPORTION750)];
    carNumLB.backgroundColor = [UIColor whiteColor];
    //    carNumLB.clipsToBounds = YES;
    //    carNumLB.layer.cornerRadius = 5*PROPORTION750;
    carNumLB.text = _dataSouce.carCode;
    carNumLB.font = SYSF750(20);
    carNumLB.textAlignment = NSTextAlignmentCenter;
    carNumLB.clipsToBounds = YES;
    carNumLB.layer.cornerRadius = 10*PROPORTION750;
    carNumLB.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
    carNumLB.layer.borderWidth = 1.0f;
    [self.view addSubview:carNumLB];
    
}

#pragma --mark orderDetailView delegate
-(void)orderDetailView:(OrderDetailView *)orderDetailView ClickEvents:(OrderDetailViewEvent)event inputString:(NSString *)inputString
{
    if (event == OrderDetailViewEventDetail)
    {
        NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       _orderNum, @"common_id",
                                       [MyHelperNO getUid], @"uid",
                                       [MyHelperNO getMyToken], @"token", nil];
        [self post:@"order/price_order" withParam:reqDic success:^(id responseObject) {
            int code = [responseObject intForKey:@"status"];
            NSLog(@"%@", responseObject);
            NSString *msg = [responseObject stringForKey:@"msg"];
            if (code == 200)
            {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                OrderPriceModel *model = [[OrderPriceModel alloc] initWithData:dic];
                OrderPriceDetailViewController *viewController = [[OrderPriceDetailViewController alloc] initWithOrderPriceModel:model];
                [self.navigationController pushViewController:viewController animated:YES];
                
            }
            else if (code == 300)
            {
                [self toast:@"身份认证已过期"];
                [self performSelector:@selector(gotoLoginViewController) withObject:nil afterDelay:1.5f];
            }
            else if (code == 400)
            {
                [self toast:msg];
            }
            
        } failure:^(NSError *error) {
            
        }];

    }
    else if (event == OrderDetailViewEventShare)
    {
        ShareView *shareView = [[ShareView alloc] init];
        shareView.shareBlock = ^(NSInteger flag){
            [self shareWebPageToPlatformType:flag];
        };

    }
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://m.xiaomachuxing.com";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用 小马出行" descr:@"欢迎使用 小马出行 优惠 便捷 一键即达！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"https://m.xiaomachuxing.com";
    
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


//计算地图显示区域
-(void)getMapViewVisbleRect
{
    //    BMKCoordinateRegion region ;//表示范围的结构体
    //    region.center = CLLocationCoordinate2DMake((self.ccMsgModel.startLocation.latitude+self.ccMsgModel.endLocation.latitude)/2, (self.ccMsgModel.startLocation.longitude+self.ccMsgModel.endLocation.longitude)/2);//中心点
    //    region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    //    region.span.longitudeDelta = 0.1;//纬度范围
    //    [_mapView setRegion:region animated:YES];
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(_dataSouce.startPlace.location);
    BMKMapPoint point2 = BMKMapPointForCoordinate(_dataSouce.endPlace.location);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    
    //这个数组就是百度地图比例尺对应的物理距离，其中2000000对应的比例是3，5对应的是21；可能有出入可以根据情况累加
    float zoomLe = 0.00;
    NSArray *zoomLevelArr = [[NSArray alloc]initWithObjects:@"2000000", @"1000000", @"500000", @"200000", @"100000", @"50000", @"25000", @"20000", @"10000", @"5000", @"2000", @"1000", @"500", @"200", @"100", @"50", @"20", @"10", @"5", nil];
    for (int j=0; j<zoomLevelArr.count; j++)
    {
        if (j + 1 < zoomLevelArr.count)
        {
            if (distance < [zoomLevelArr[j] intValue] && distance > [zoomLevelArr[j+1] intValue] )
            {
                //                [_mapView setZoomLevel:j+6];
                zoomLe = j+6.4;
                break;
            }
        }
    }
    
    BMKMapStatus *status = [[BMKMapStatus alloc] init];
    status.fLevel = zoomLe;
    status.targetScreenPt = CGPointMake(AL_DEVICE_WIDTH/2, 450*PROPORTION750);
    status.targetGeoPt = CLLocationCoordinate2DMake((_dataSouce.startPlace.location.latitude+_dataSouce.endPlace.location.latitude)/2,
                                                    (_dataSouce.startPlace.location.longitude+_dataSouce.endPlace.location.longitude)/2);
    [self.mapView setMapStatus:status withAnimation:YES];
    
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
