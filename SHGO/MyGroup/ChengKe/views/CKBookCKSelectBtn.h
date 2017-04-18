//
//  CKBookCKSelectBtn.h
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKBookCKSelectBtn;
@protocol CKBookCKSelectBtnDelegate <NSObject>

-(void)CKBookCKSelectBtn:(CKBookCKSelectBtn *)btn isSelected:(BOOL)isSelected;

@end

@interface CKBookCKSelectBtn : UIView

@property (nonatomic, strong) id<CKBookCKSelectBtnDelegate> delegate;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) NSString *nameStr;

@end
