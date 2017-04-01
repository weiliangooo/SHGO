//
//  AssetPickerCell.h
//  taiben_ipad
//
//  Created by lbf on 14-8-21.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAAssetData.h"

@interface AssetPickerCell : UICollectionViewCell

@property (nonatomic) BOOL isPicked;
/**
 通过asset初始化
 */
-(void)initWithAsset:(XAAssetData *)data;
/**
 点击cell
 */
-(void)cellTaped;

@end
