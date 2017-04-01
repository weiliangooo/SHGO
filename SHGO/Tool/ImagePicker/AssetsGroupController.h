//
//  AssetsGroupController.h
//  taiben_ipad
//
//  Created by lbf on 14-8-20.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//



#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetPickerController.h"

typedef enum : NSInteger
{
    AssetsPickTypeAll,
    AssetsPickTypeImage,
    AssetsPickTypeVideo
}AssetsPickType;

@interface AssetsGroupController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic) UITableView *tableView;

@property (nonatomic) int maxCount;
@property (nonatomic) int minCount;

@property (nonatomic) AssetsPickType picktype;

@property (nonatomic, strong) void(^assetPicked)(NSArray *result);

@end
