//
//  MyStar.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/21.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "MyStar.h"
#import "StarImageView.h"

@interface MyStar()
{
    CGFloat starSize;
}

@end

@implementation MyStar

-(instancetype)initWithFrame:(CGRect)frame space:(CGFloat)space{
    if (self = [super initWithFrame:frame]){
        starSize = (self.width-6*space)/5;
        for (int i = 0; i < 5 ; i++){
            StarImageView *button = [[StarImageView alloc] initWithFrame:CGRectMake(space + (space+starSize)*i, (self.height-starSize)/2, starSize, starSize)];
            button.tag = 100+i;
            button.curStatus = StarImageViewStatusOff;
            button.userInteractionEnabled = YES;
            [button addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapEvents:)]];
            [self addSubview:button];
        }
    }
    return self;
}

-(void)viewTapEvents:(UITapGestureRecognizer *)tap{
    if (_isCanTap){
        for (int i = 0; i < 5 ; i++){
            StarImageView *button = [self viewWithTag:100+i];
            if (i+100 <= [tap view].tag){
                button.curStatus = StarImageViewStatusOn;
            }else{
                button.curStatus = StarImageViewStatusOff;
            }
        }
    }else{
        NSLog(@"haha");
    }
}

-(NSString *)getScore{
    CGFloat score = 0.00;
    for (int i = 0; i < 5 ; i++)
    {
        StarImageView *button = [self viewWithTag:100+i];
        if(button.curStatus == StarImageViewStatusOn){
            score = score + 1;
        }else if(button.curStatus == StarImageViewStatusHalf){
            score = score + 0.5;
        }
    }
    return [NSString stringWithFormat:@"%.2f",score];
}

-(void)setScore:(CGFloat)score
{
    int onNum = score/1;
    CGFloat more = score - onNum;
    
    for (int i = 0; i < 5 ; i++)
    {
        StarImageView *button = [self viewWithTag:100+i];
        
        if(button.tag < onNum+100)
        {
            button.curStatus = StarImageViewStatusOn;
        }
        else if(button.tag == onNum+100)
        {
            if (more < 0.25)
            {
                button.curStatus = StarImageViewStatusOff;
            }
            else if (more > 0.75)
            {
                button.curStatus = StarImageViewStatusOn;
            }
            else
            {
                button.curStatus = StarImageViewStatusHalf;
            }
        }
        else
        {
            button.curStatus = StarImageViewStatusOff;
        }
    }

    
}

@end
