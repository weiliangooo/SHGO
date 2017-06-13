//
//  CKLoginTextField.h
//  SHGO
//
//  Created by Alen on 2017/3/23.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextField : UIView

///textfield左边的图片
@property (nonatomic, strong) NSString *leftImgName;

///textfield默认文字
@property (nonatomic, strong) NSString *placeholderTitle;

///定义一个textfield属性
@property (nonatomic, strong) UITextField *myTextField;

/*
 *  定义初始化方法
 */
-(instancetype)initWithFrame:(CGRect)frame
                 leftImgName:(NSString *)leftImgName
            placeholderTitle:(NSString *)placeholderTitle;


@end
