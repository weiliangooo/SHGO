//
//  CKTimeSelectView.h
//  SHGO
//
//  Created by Alen on 2017/3/24.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKTimeSelectView : UIView

@property (nonatomic, copy) void (^CKTimeSelectBlock)(BOOL isCanCle);

@property (nonatomic, strong) NSMutableArray *dataArray;

-(instancetype)initWithData:(NSMutableArray *)array;

@end
