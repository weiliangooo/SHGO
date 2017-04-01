//
//  AssetPickerCell.m
//  taiben_ipad
//
//  Created by lbf on 14-8-21.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "AssetPickerCell.h"

@interface AssetPickerCell()
{
    UIImageView *cellImageView;
    UIView *selectedView;
    UIView *videoLayer;
//    UIImageView *videoIcon;
}

@end

@implementation AssetPickerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isPicked = NO;
        [self initCell];
    }
    return self;
}

-(void)initCell
{
    //图片
    CGSize viewSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
    [cellImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:cellImageView];
    //视频标志
    videoLayer = [[UIView alloc] initWithFrame:CGRectMake(0, viewSize.height-19, viewSize.width, 19)];
    [videoLayer setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [videoLayer setHidden:YES];
    [cellImageView addSubview:videoLayer];
    UIImageView *videoIcon = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 16, 11)];
    [videoIcon setImage:[UIImage imageNamed:@"assetVideo"]];
    [videoLayer addSubview:videoIcon];
    //选中浮层
    selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
    [selectedView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [selectedView setHidden:YES];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(viewSize.width-30, viewSize.height-30, 26, 26)];
    [icon setImage:[UIImage imageNamed:@"assetPicked"]];
    [selectedView addSubview:icon];
    [self addSubview:selectedView];
}

-(void)initWithAsset:(XAAssetData *)data
{
    //是否视频类型
    [videoLayer setHidden:!data.isVideoType];
    //设置图片
    [cellImageView setImage:data.poster];
}

-(void)setIsPicked:(BOOL)isPicked
{
    _isPicked = isPicked;
    [self bringSubviewToFront:selectedView];
    [selectedView setHidden:!_isPicked];
}

-(void)cellTaped
{
//    [self bringSubviewToFront:selectedView];
//    [selectedView setHidden:self.isPicked];
    self.isPicked = !self.isPicked;
}

@end
