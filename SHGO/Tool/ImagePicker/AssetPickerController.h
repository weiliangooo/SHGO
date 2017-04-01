//
//  AssetPickerController.h
//  taiben_ipad
//
//  Created by lbf on 14-8-21.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "XAAssetData.h"

@interface AssetPickerController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ALAssetsGroup *assetGroup;
@property (nonatomic) UICollectionView *tableView;

@property (nonatomic) int maxCount;
@property (nonatomic) int minCount;

@property (nonatomic, strong) void(^assetPicked)(NSArray *result);

@end
