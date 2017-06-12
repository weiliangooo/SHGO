//
//  TitleTextField.m
//  SHGO
//
//  Created by 魏亮 on 2017/6/6.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "TitleTextField.h"

@implementation TitleTextField

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40*PROPORTION750, 2*PROPORTION750, 150*PROPORTION750, 98*PROPORTION750)];
        _titleLB.textColor = [UIColor colorWithHexString:@"#666666"];
        _titleLB.font = SYSF750(30);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        _contentTF = [[UITextField alloc] initWithFrame:CGRectMake(_titleLB.right, 2*PROPORTION750, 480*PROPORTION750, 98*PROPORTION750)];
        _contentTF.font = SYSF750(35);
        [self addSubview:_contentTF];
    }
    return self;
}

@end
