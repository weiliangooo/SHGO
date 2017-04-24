//
//  CKListModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/24.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CKListSingelModel;
@interface CKListModel : NSObject

@property (nonatomic, strong)NSMutableArray<CKListSingelModel *> *ckListModels;

-(instancetype)initWithData:(NSArray *)dataSoure;

@end


@interface CKListSingelModel : NSObject

@property (nonatomic, strong) NSString *ckId;

@property (nonatomic, strong) NSString *ckName;

@property (nonatomic, strong) NSString *ckNumber;

@property (nonatomic, strong) NSString *ckPhone;

-(instancetype)initWithData:(NSDictionary *)dataSoure;

@end
