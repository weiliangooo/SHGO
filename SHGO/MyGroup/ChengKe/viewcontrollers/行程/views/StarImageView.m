//
//  StarImageView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "StarImageView.h"

@implementation StarImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setCurStatus:(StarImageViewStatus)curStatus
{
    if (curStatus == StarImageViewStatusOff)
    {
        self.image = [UIImage imageNamed:@"star_0"];
    }
    else if (curStatus == StarImageViewStatusHalf)
    {
        self.image = [UIImage imageNamed:@"star_1"];
    }
    else if(curStatus == StarImageViewStatusOn)
    {
        self.image = [UIImage imageNamed:@"star_2"];
    }
}

@end
