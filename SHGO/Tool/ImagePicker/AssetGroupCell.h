//
//  AssetGroupCell.h
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAAssetData.h"

@interface AssetGroupCell : UITableViewCell
-(void) initGroupCell;
/**
 设置标题
 */
-(void)setTitle:(NSString *)title;
/**
 设置图片
 */
-(void)setImage:(UIImage *)image;
@end
