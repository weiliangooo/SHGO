//
//  XACameraController.h
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XAAssetData.h"

typedef enum : NSInteger
{
    CameraTypeAll,
    CameraTypeImage,
    CameraTypeVideo
}CameraType;

@interface XACameraController : UIImagePickerController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) void(^pickupCompletion)(XAAssetData *assetData);
@property (nonatomic, strong) void(^pickupFailure)(NSError *error);
@property (nonatomic) CameraType type;
/**
 获得相机实例
 */
+(XACameraController *)cameraWithCaremaType:(CameraType)type Completion:(void (^)(XAAssetData*))completion faile:(void(^)(NSError*))failure;
/**
 检查设备是否支持摄像头
 */
+(BOOL)isCaremaAvailable;
/**
 初始化相机参数
 */
-(void)initCarama;

@end
