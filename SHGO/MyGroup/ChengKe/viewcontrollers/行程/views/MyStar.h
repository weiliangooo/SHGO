//
//  MyStar.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStar : UIView

@property (nonatomic, assign) BOOL isCanTap;

-(instancetype)initWithFrame:(CGRect)frame space:(CGFloat)space;

-(NSString *)getScore;
-(void)setScore:(CGFloat)score;

@end

