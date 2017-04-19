//
//  CKBookCKSelectBtn.m
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKBookCKSelectBtn.h"

@interface CKBookCKSelectBtn()

@property (nonatomic, strong)UIImageView *selectedView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CKBookCKSelectBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        
        _selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30*PROPORTION750, 30*PROPORTION750)];
        _selectedView.image = [UIImage imageNamed:@"ckunselected"];
        [self addSubview:_selectedView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_selectedView.right+10*PROPORTION750, 0, 70*PROPORTION750, 30*PROPORTION750)];
        _nameLabel.text = @"hshdhf";
        _nameLabel.font = SYSF750(30);
        [self addSubview:_nameLabel];
        
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected)
    {
        _selectedView.image = [UIImage imageNamed:@"ckselected"];
    }
    else
    {
        _selectedView.image = [UIImage imageNamed:@"ckunselected"];
    }
}

-(void)setNameStr:(NSString *)nameStr
{
    _nameStr = nameStr;
    
    CGSize size = [self currentText:_nameStr textFont:SYSF750(30) maxSize:CGSizeMake(200*PROPORTION750, 30*PROPORTION750)];
    _nameLabel.text = _nameStr;
    _nameLabel.width = size.width;
    
    self.width = _nameLabel.width+40*PROPORTION750;
}

//根据字体的大小和文字 计算所需的尺寸
-(CGSize)currentText:(NSString *)text textFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size;
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(CKBookCKSelectBtn:isSelected:)])
    {
        [_delegate CKBookCKSelectBtn:self isSelected:_isSelected];
    }
}


@end
