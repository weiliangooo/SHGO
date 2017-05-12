//
//  StarImageView.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "StarImageView.h"

@implementation StarImageView

-(void)setCurStatus:(StarImageViewStatus)curStatus{
    _curStatus = curStatus;
    if (_curStatus == StarImageViewStatusOff){
        self.image = [UIImage imageNamed:@"star_0"];
    }else if (_curStatus == StarImageViewStatusHalf){
        self.image = [UIImage imageNamed:@"star_1"];
    }else if(_curStatus == StarImageViewStatusOn){
        self.image = [UIImage imageNamed:@"star_2"];
    }
}

@end
