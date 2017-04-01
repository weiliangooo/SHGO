//
//  XACameraController.m
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "XACameraController.h"
#import <AVFoundation/AVFoundation.h>

@interface XACameraController ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation XACameraController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(XACameraController *)cameraWithCaremaType:(CameraType)type Completion:(void (^)(XAAssetData *))completion faile:(void (^)(NSError *))failure
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"打开相机失败"
                                                       message:@"请打开 设置-隐私-相册 来进行设置"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }
    XACameraController *camera = [[XACameraController alloc] init];
    [camera setType:type];
    [camera initCarama];
    [camera setPickupCompletion:completion];
    [camera setPickupFailure:failure];
    return camera;
}

-(void)initCarama
{
    self.delegate = self;
    self.allowsEditing = YES;
}

-(void)setType:(CameraType)type
{
    _type = type;
    switch (_type) {
        case CameraTypeImage:
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case CameraTypeVideo:{
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.videoQuality = UIImagePickerControllerQualityType640x480;
            NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            self.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
        }
            break;
        default:
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            self.videoQuality = UIImagePickerControllerQualityType640x480;
            break;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(BOOL)isCaremaAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    void(^completion)(NSURL *assetURL, NSError *error) = ^(NSURL *assetURL, NSError *error) {
        [self.assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            if (self.pickupCompletion) {
                XAAssetData *data = [XAAssetData dataWith:asset];
                self.pickupCompletion(data);
            }
        } failureBlock:^(NSError *error) {
            if (self.pickupFailure) {
                self.pickupFailure(error);
            }
        }];
    };
    
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"]){//被选中的是视频
		NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        //保存视频到相册
        [self.assetsLibrary writeVideoAtPathToSavedPhotosAlbum:url completionBlock:completion];
    }else if ([mediaType isEqualToString:@"public.image"]) {//图片
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        //保存到相册
        [self.assetsLibrary writeImageToSavedPhotosAlbum:[image CGImage]
                                  orientation:(ALAssetOrientation)[image imageOrientation]
                              completionBlock:completion];
    }
    
}

-(ALAssetsLibrary *)assetsLibrary
{
    static ALAssetsLibrary *_library = nil;
    if (_library == nil) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
