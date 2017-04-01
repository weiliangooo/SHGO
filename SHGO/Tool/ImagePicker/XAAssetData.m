//
//  XAAssetData.m
//  taiben_ipad
//
//  Created by lbf on 14-8-21.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "XAAssetData.h"

@interface XAAssetData()
@end

@implementation XAAssetData

+(XAAssetData *)dataWith:(ALAsset *)asset
{
    XAAssetData *data = [[XAAssetData alloc] init];
    [data setOriginalData:asset];
    return data;
}

-(void)setOriginalData:(ALAsset *)originalData
{
    _originalData = originalData;
    
    NSString *assetType = [originalData valueForProperty:ALAssetPropertyType];
    if ([assetType isEqualToString:ALAssetTypePhoto]) {
        self.assetType = AssetTypeImage;
    }else if ([assetType isEqualToString:ALAssetTypeVideo]) {
        self.assetType = AssetTypeVideo;
    }else {
        self.assetType = AssetTypeUnknow;
    }
}
//资源的详细信息
-(ALAssetRepresentation *)representation
{
    if (_representation == nil) {
        _representation = [self.originalData defaultRepresentation];
    }
    return _representation;
}
//文件名
-(NSString *)fileName
{
    if (_fileName == nil) {
        _fileName = [self.representation filename];
    }
    return _fileName;
}
//缩略图
-(UIImage *)poster
{
    if (_poster == nil) {
        _poster = [UIImage imageWithCGImage:self.originalData.thumbnail];
    }
    return _poster;
}
//压缩图
-(UIImage*)representationImg{
    if (_representation==nil) {
        NSData * imageData = UIImageJPEGRepresentation(self.poster, 0.0001);
        NSLog(@"%lu",(unsigned long)imageData.length);
        _representationImg=[UIImage imageWithData:imageData];
    }
    return _representationImg;
    
}
//高清图
-(UIImage *)fullResolutionImage
{
    if (_fullResolutionImage == nil) {
        _fullResolutionImage = [UIImage imageWithCGImage:[self.representation fullResolutionImage]];
    }
    return _fullResolutionImage;
}
//全屏图
-(UIImage *)fullScreenImage
{
    if (_fullScreenImage == nil) {
        _fullScreenImage = [UIImage imageWithCGImage:[self.representation fullScreenImage]];
    }
    return _fullScreenImage;
}
//文件url
-(NSURL *)fileURL
{
    if (_fileURL == nil) {
        _fileURL = [self.representation url];
    }
    return _fileURL;
}
//mime类型
-(NSString *)MIMEType
{
    if (_MIMEType == nil) {
        ALAssetRepresentation *rep = [self.originalData defaultRepresentation];
        _MIMEType = (__bridge_transfer NSString*)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)[rep UTI],kUTTagClassMIMEType);
    }
    return _MIMEType;
}

-(NSData *)fileData
{
    ALAssetRepresentation *assetRep = [self.originalData defaultRepresentation];
    NSUInteger size = (NSInteger)[assetRep size];
    uint8_t *buff = malloc(size);
    NSError *err = nil;
    NSUInteger gotByteCount = [assetRep getBytes:buff fromOffset:0 length:size error:&err];
    if (gotByteCount) {
        if (err) {
            NSLog(@"!!! Error reading asset: %@", [err localizedDescription]);
            free(buff);
            return nil;
        }
    }
    return [NSData dataWithBytesNoCopy:buff length:size freeWhenDone:YES];
    
}

-(BOOL)isImageType
{
    return self.assetType == AssetTypeImage;
}

-(BOOL)isVideoType
{
    return self.assetType == AssetTypeVideo;
}

@end
