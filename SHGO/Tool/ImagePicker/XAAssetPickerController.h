//
//  XAAssetPickerController.h
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "BaseNavViewController.h"
#import "AssetsGroupController.h"

@interface XAAssetPickerController : BaseNavViewController

+(XAAssetPickerController *)pickerWithPickType:(AssetsPickType)tye Completion:(void (^)(NSArray*))pickup;

@property (nonatomic) int maxCount;
@property (nonatomic) int minCount;

@end
