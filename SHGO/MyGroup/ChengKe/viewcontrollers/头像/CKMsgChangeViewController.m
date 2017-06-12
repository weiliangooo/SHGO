//
//  CKMsgChangeViewController.m
//  SHGO
//
//  Created by Alen on 2017/4/9.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKMsgChangeViewController.h"
#import "PopAleatView.h"
#import "XAAssetData.h"
#import "UploadFileData.h"
#import "XAAssetPickerController.h"
#import "XACameraController.h"
#import "TitleTextField.h"

@interface CKMsgChangeViewController ()<PopAleatViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray *postArray;
    TitleTextField *nameTF;
    TitleTextField *phoneTF;
    TitleTextField *idTF;
}
@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UITextField *nameTF;

@end

@implementation CKMsgChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type = 6;
    self.topTitle = @"编辑资料";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(20*PROPORTION750, 30*PROPORTION750, 710*PROPORTION750, 280*PROPORTION750)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.clipsToBounds = YES;
    myView.layer.cornerRadius = 15*PROPORTION750;
    [self.view addSubview:myView];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(40*PROPORTION750, 30*PROPORTION750, 120*PROPORTION750, 120*PROPORTION750)];
    _headImg.clipsToBounds = YES;
    _headImg.layer.cornerRadius = 60*PROPORTION750;
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[MyHelperNO getMyHeadImage]] placeholderImage:[UIImage imageNamed:@"default"]];
    _headImg.userInteractionEnabled = YES;
    [_headImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClickEvent:)]];
    [myView addSubview:_headImg];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(_headImg.right+30*PROPORTION750, 75*PROPORTION750, 140*PROPORTION750, 30*PROPORTION750)];
    tipLB.text = @"修改头像";
    tipLB.textColor = [UIColor colorWithHexString:@"##cccccc"];
    tipLB.font = SYSF750(30);
    tipLB.textAlignment = NSTextAlignmentLeft;
    [myView addSubview:tipLB];
    
//    nameTF = [[TitleTextField alloc] initWithFrame:CGRectMake(0, 180*PROPORTION750, 710*PROPORTION750, 100*PROPORTION750)];
//    nameTF.titleLB.text = @"姓名";
//    nameTF.contentTF.placeholder = @"请输入姓名";
//    nameTF.contentTF.text = [MyHelperNO getMyRealName];
//    [myView addSubview:nameTF];
//    
//    phoneTF = [[TitleTextField alloc] initWithFrame:CGRectMake(0, 280*PROPORTION750, 710*PROPORTION750, 100*PROPORTION750)];
//    phoneTF.titleLB.text = @"手机号";
//    phoneTF.contentTF.placeholder = @"请输入手机号";
//    phoneTF.contentTF.text = [MyHelperNO getMyMobilePhone];
//    [myView addSubview:phoneTF];
//    
//    idTF = [[TitleTextField alloc] initWithFrame:CGRectMake(0, 380*PROPORTION750, 710*PROPORTION750, 100*PROPORTION750)];
//    idTF.titleLB.text = @"身份证";
//    idTF.contentTF.placeholder = @"请输入身份证";
//    idTF.contentTF.text = [MyHelperNO getMyIdentNo];
//    [myView addSubview:idTF];
//    
//    UILabel *bottomLB = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, myView.bottom+30*PROPORTION750, 630*PROPORTION750, 30*PROPORTION750)];
//    bottomLB.text = @"*这些信息涌来登记和赠送保险";
//    bottomLB.textColor = [UIColor colorWithHexString:@"666666"];
//    bottomLB.font = SYSF750(30);
//    bottomLB.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:bottomLB];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 178*PROPORTION750, 710*PROPORTION750, 2*PROPORTION750)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [myView addSubview:line];
    
    UILabel *tip2LB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, line.bottom+32.5*PROPORTION750, 120*PROPORTION750, 35*PROPORTION750)];
    tip2LB.text = @"手机号";
    tip2LB.textColor = [UIColor colorWithHexString:@"#666666"];
    tip2LB.font = SYSF750(30);
    tip2LB.textAlignment = NSTextAlignmentLeft;
    [myView addSubview:tip2LB];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(tip2LB.right+30*PROPORTION750, line.bottom+32.5*PROPORTION750, 450*PROPORTION750, 35*PROPORTION750)];
    _nameTF.placeholder = @"请输入昵称";
    _nameTF.text = [[MyHelperNO getMyMobilePhone] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _nameTF.enabled = NO;
    _nameTF.textAlignment = NSTextAlignmentLeft;
    _nameTF.font = SYSF750(35);
    [myView addSubview:_nameTF];
    
}

-(void)headImageClickEvent:(UITapGestureRecognizer *)tap
{
    PopAleatView *myPopAV = [[PopAleatView alloc] init];
    [myPopAV setButtonStr1:@"拍照" Str2:@"从手机相册选择"];
    myPopAV.delegate = self;
}

-(void)onClick:(UIButton *)sender setbtn:(UIButton *)btn popAleatView:(id)popAleatView
{
    if (sender.tag==0)
    {
        //检查摄像头是否支持摄像机模式
        if ([XACameraController isCaremaAvailable])
        {
            [self presentViewController:[XACameraController cameraWithCaremaType:CameraTypeImage Completion:^(XAAssetData *result) {
                if ([result isImageType]) {
                    postArray = [NSMutableArray array];
                    
                    XAAssetData *data = result;
                    _headImg.image = data.fullScreenImage;
                    
                    UploadFileData * picData=[[UploadFileData alloc]init];
                    if (data.fileData){
                        picData.postName = [NSString stringWithFormat:@"poster"];
                        picData.fileName = data.fileName;
                        //                        picData.fileData = data.fileData;
                        picData.mimeType = data.MIMEType;
                        
                        //
                        NSData *postData = UIImageJPEGRepresentation(data.fullScreenImage, 1);
                        if (postData.length>100*1000)
                        {
                            double resultSize = 100000.0/postData.length;
                            NSLog(@"%lu, %f", (unsigned long)postData.length, resultSize);
                            postData=UIImageJPEGRepresentation(data.fullScreenImage, resultSize);
                        }
                        picData.fileData = postData;
                        
                        NSLog(@"%lu", (unsigned long)postData.length);
                        [postArray addObject:picData];
                    }
                }
            } faile:^(NSError *error) {
                
            }] animated:YES completion:nil];
             
        }
        else
        {
            [self alertMessage:@"该设备不支持摄像头"];
            return;
        }
    }
    else
    {
        XAAssetPickerController *picker = [XAAssetPickerController pickerWithPickType:AssetsPickTypeAll Completion:^(NSArray *result){
            XAAssetData *resultData = [result objectAtIndex:0];
            _headImg.image = resultData.fullScreenImage;
            if ([resultData isImageType]) {
                postArray = [NSMutableArray array];
                
                UploadFileData * picData = [[UploadFileData alloc]init];
                if (resultData.fileData){
                    picData.postName = [NSString stringWithFormat:@"poster"];
                    picData.fileName = resultData.fileName;
                    //                        picData.fileData = resultData.fileData;
                    
                    NSData *postData = UIImageJPEGRepresentation(resultData.fullScreenImage, 1.0);
                    if (postData.length>100*1024)
                    {
                        double resultSize = 102400.0/postData.length;
                        postData=UIImageJPEGRepresentation(resultData.fullScreenImage, resultSize);
                    }
                    picData.fileData = postData;
                    picData.mimeType = resultData.MIMEType;
                    [postArray addObject:picData];
                }
                
            }
            
        }];
        [picker setMaxCount:1];
        [self presentViewController:picker animated:YES completion:nil];
    }

}

-(void)rightBtn:(UIButton *)button
{
    if (postArray == nil)
    {
        [self toast:@"请选择要上传的图片！"];
        return;
    }
    NSMutableDictionary *reqDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [MyHelperNO getUid], @"uid",
                                   [MyHelperNO getMyToken], @"token", nil];
    [self POSTMultipartForm:@"user/avatar" param:reqDic files:postArray completion:^(id responseObject, NSError *error) {
        int code = [responseObject intForKey:@"status"];
        NSLog(@"%@", responseObject);
        NSString *msg = [responseObject stringForKey:@"msg"];
        if (code == 200)
        {
            [self toast:msg];
            [USERDEFAULTS setObject:[responseObject stringForKey:@"data"] forKey:@"headImage"];
            [self performSelector:@selector(exitCurrent) withObject:nil afterDelay:1.5f];
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
    } progress:^(float progress) {
        
    }];
}

-(void)exitCurrent
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
