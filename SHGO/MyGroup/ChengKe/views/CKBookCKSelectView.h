//
//  CKBookCKSelectView.h
//  SHGO
//
//  Created by Alen on 2017/3/29.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKBookCKSelectBtn.h"

@interface CKBookCKSelectView : UIView

@property (nonatomic, strong) UITableView *selectCKTable;

@property (nonatomic, strong) UICollectionView *myCollectionView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@end


//@interface CKCollectionCell : UICollectionViewCell
//
//@property (nonatomic, assign) BOOL isSelected;
//
//@property (nonatomic, strong) CKBookCKSelectBtn *myBtn;
//
//@end
//
//
//@interface CkCollectionHeader : UICollectionReusableView
//
//
//@end
//
//
//@interface CKCollectionFooter : UICollectionReusableView
//
//@end


@interface CKBookCKSelectDetailView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSMutableArray *)dataArray;

@end
