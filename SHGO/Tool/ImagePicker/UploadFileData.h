//
//  UploadFileData.h
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XAAssetData.h"

@interface UploadFileData : NSObject

@property (nonatomic) NSString *fileName;
@property (nonatomic) NSData *fileData;
@property (nonatomic) NSString *postName;
@property (nonatomic) NSString *mimeType;

-(void)initWithAssetData:(XAAssetData *)data;

@end
