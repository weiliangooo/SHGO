//
//  NoDataView.h
//  LightBuy
//
//  Created by Alen on 16/10/18.
//  Copyright © 2016年 Abel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView

@property(nonatomic, strong) UIImageView *imgView;          /*没有数据时 显示界面的*/
@property(nonatomic, strong) UILabel *tipLabel;             /*没有数据时 显示提示标语*/

@property(nonatomic, assign) CGSize imgSize;                /*自定义img 的宽高  默认  （210x105）  */
@property(nonatomic, assign) CGSize tipSize;                /*自定义img 的宽高  默认  （320x20）*/

@property(nonatomic, copy) void (^refreshBlock)();          /*点击图片和文字出发block*/

@end
