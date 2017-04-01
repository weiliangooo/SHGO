//
//  XAAssetData.h
//  taiben_ipad
//
//  Created by lbf on 14-8-21.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    AssetTypeImage,
    AssetTypeVideo,
    AssetTypeUnknow
}AssetType;

@interface XAAssetData : NSObject
@property (nonatomic) ALAssetRepresentation* representation;
/**
 通过ALAsset获取实例
 */
+(XAAssetData *)dataWith:(ALAsset *)asset;
/**
 数据类型
 */
@property (nonatomic) AssetType assetType;
/**
 原始ALAsset数据
 */
@property (nonatomic) ALAsset *originalData;
/**
 资源文件名称
 */
@property (nonatomic) NSString *fileName;
/**
 封面缩略图片
 */
@property (nonatomic) UIImage *poster;
/**
 压缩图
 **/
@property(nonatomic)UIImage *representationImg;
/**
 高清图
 */
@property (nonatomic) UIImage *fullResolutionImage;
/**
 全屏图
 */
@property (nonatomic) UIImage *fullScreenImage;
/**
 文件地址
 */
@property (nonatomic) NSURL *fileURL;
/**
 是否是图片
 */
@property (nonatomic) BOOL isImageType;
/**
 是否是视频
 */
@property (nonatomic) BOOL isVideoType;
/**
 MIME类型
 */
@property (nonatomic) NSString* MIMEType;
/**
 文件Data
 */
@property (nonatomic) NSData *fileData;

@end
