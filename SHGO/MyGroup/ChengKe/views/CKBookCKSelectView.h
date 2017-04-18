//
//  CKBookCKSelectView.h
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKBookCKSelectBtn.h"
#import "CKMsgModel.h"


@class CKBookCKSelectView;
@class CKBookCKSelectDetailView;

@protocol BookCKSelectDetailViewDelegate <NSObject>

-(void)CKBookCKSelectView:(CKBookCKSelectView *)selectView selectData:(NSMutableArray *)data;

@end

@interface CKBookCKSelectView : UIView

@property (nonatomic, strong) UITableView *selectCKTable;

@property (nonatomic, strong) UICollectionView *myCollectionView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) CKBookCKSelectDetailView *detailView;

@property (nonatomic, strong) NSMutableArray <CKMsgModel *> *allCKData;
@property (nonatomic, strong) NSMutableArray <CKMsgModel *> *selectData;

-(instancetype)initWithFrame:(CGRect)frame allData:(NSMutableArray *)allCKData selectData:(NSMutableArray *)selectData;

@end



@interface CKBookCKSelectDetailView : UIView <CKBookCKSelectBtnDelegate>

@property (nonatomic, assign) id<BookCKSelectDetailViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray <CKMsgModel *> *allCKData;
@property (nonatomic, strong) NSMutableArray <CKMsgModel *> *selectData;

-(instancetype)initWithFrame:(CGRect)frame allData:(NSMutableArray *)allCKData selectData:(NSMutableArray *)selectData;

@end
