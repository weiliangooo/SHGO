//
//  PopAleatView.h
//  Market
//
//  Created by yangH4 on 15/12/30.
//  Copyright © 2015年 yingzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopAleatViewDelegate <NSObject>
-(void)onClick:(UIButton*)sender setbtn:(UIButton*)btn;

-(void)onClick:(UIButton *)sender setbtn:(UIButton *)btn popAleatView:(id)popAleatView;
@end


@interface PopAleatView : UIView
-(void)setButtonStr1:(NSString *)str1 Str2:(NSString *)str2;



@property(nonatomic)UIButton *btn;

@property (nonatomic) id<PopAleatViewDelegate> delegate;

@end
