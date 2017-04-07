//
//  CKPayView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/7.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "CKPayView.h"

@implementation CKPayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        self.userInteractionEnabled = YES;
//        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test:)]];
        
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-530*PROPORTION750, self.width, 530*PROPORTION750)];
        myView.backgroundColor = [UIColor whiteColor];
        [self addSubview:myView];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750, 30*PROPORTION750)];
        [closeBtn setImage:[UIImage imageNamed:@"pay_close"] forState:UIControlStateNormal];
        [myView addSubview:closeBtn];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, self.width-120*PROPORTION750, 30*PROPORTION750)];
        title.text = @"选择付款方式";
        title.font = SYSF750(30);
        title.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:title];
        
        for (int i = 0; i < 3; i++)
        {
            CKPayCell *cell = [[CKPayCell alloc] initWithFrame:CGRectMake(0, 90*PROPORTION750+105*PROPORTION750*i, self.width, 105*PROPORTION750)];
            cell.tag = 100+i;
            if (i == 0)
            {
                cell.isSelected = YES;
            }
            __block typeof(cell) blockCell = cell;
            cell.selectedBlock = ^(){
                if (blockCell.tag == 100)
                {
                    blockCell.isSelected = YES;
                    CKPayCell *cell2 = [self viewWithTag:101];
                    cell2.isSelected = NO;
                    CKPayCell *cell3 = [self viewWithTag:102];
                    cell3.isSelected = NO;
                }
                else if (cell.tag == 101)
                {
                    blockCell.isSelected = YES;
                    CKPayCell *cell2 = [self viewWithTag:100];
                    cell2.isSelected = NO;
                    CKPayCell *cell3 = [self viewWithTag:102];
                    cell3.isSelected = NO;
                }
                else
                {
                    blockCell.isSelected = YES;
                    CKPayCell *cell2 = [self viewWithTag:100];
                    cell2.isSelected = NO;
                    CKPayCell *cell3 = [self viewWithTag:101];
                    cell3.isSelected = NO;
                }
            };
            
            [myView addSubview:cell];
        }
        
        UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*PROPORTION750, 405*PROPORTION750, self.width-60*PROPORTION750, 100*PROPORTION750)];
        payBtn.backgroundColor = [UIColor colorWithHexString:@"#1aad19"];
        payBtn.clipsToBounds = YES;
        payBtn.layer.cornerRadius = 15*PROPORTION750;
        [payBtn setTitle:@"确认付款¥15.50" forState:UIControlStateNormal];
        payBtn.titleLabel.font = SYSF750(35);
        payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [payBtn addTarget:self action:@selector(payBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:payBtn];
        
    }
    return self;
}


-(void)payBtnClickEvent:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(CKPayViwePayBtnClickEvent)])
    {
        [_delegate CKPayViwePayBtnClickEvent];
    }
//    [self removeFromSuperview];
}



@end

@interface CKPayCell()
{
    UIImageView *selectImage;
}

@end

@implementation CKPayCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 2*PROPORTION750)];
        line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        [self addSubview:line];
        
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(60*PROPORTION750, 30*PROPORTION750, 45*PROPORTION750, 45*PROPORTION750)];
        _headImage.clipsToBounds = YES;
        _headImage.layer.cornerRadius = 22.5*PROPORTION750;
        _headImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_headImage];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(_headImage.right+20*PROPORTION750, _headImage.top+7.5*PROPORTION750, 500*PROPORTION750, 30*PROPORTION750)];
        _titleLB.text = @"adfsadfsa";
        _titleLB.font = SYSF750(25);
        _titleLB.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLB];
        
        
        selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-100*PROPORTION750, 32.5*PROPORTION750, 40*PROPORTION750, 40*PROPORTION750)];
        selectImage.backgroundColor = [UIColor grayColor];
        selectImage.userInteractionEnabled = YES;
        [selectImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImageClickEvent:)]];
        [self addSubview:selectImage];
        
    }
    return self;
}

-(void)selectImageClickEvent:(UITapGestureRecognizer *)tap
{
    self.selectedBlock();
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected)
    {
        selectImage.backgroundColor = [UIColor greenColor];
    }
    else
    {
        selectImage.backgroundColor = [UIColor grayColor];
    }
}

@end
