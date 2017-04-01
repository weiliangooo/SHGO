//
//  AssetGroupCell.m
//  taiben_ipad
//
//  Created by lbf on 14-8-22.
//  Copyright (c) 2014年 xun-ao. All rights reserved.
//

#import "AssetGroupCell.h"

@interface AssetGroupCell()
{
    UIImageView *posterView;
    UILabel *titleLabel;
}
@end

@implementation AssetGroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) initGroupCell
{
    float height = self.frame.size.height-20;
    posterView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, height, height)];
    [posterView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:posterView];
    
    float x = posterView.frame.origin.x+posterView.frame.size.width+20;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 10, self.frame.size.width-x-10, height)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:titleLabel];
}

-(void)setTitle:(NSString *)title
{
    [titleLabel setText:title];
}

-(void)setImage:(UIImage *)image
{
    [posterView setImage:image];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
