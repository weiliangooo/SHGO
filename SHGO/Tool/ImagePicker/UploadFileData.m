//
//  UploadFileData.m
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "UploadFileData.h"

@implementation UploadFileData

-(void)initWithAssetData:(XAAssetData *)data
{
    self.fileName = data.fileName;
    self.fileData = data.fileData;
    self.postName = @"img";
    self.mimeType = data.MIMEType;
}

@end
