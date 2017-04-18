//
//  CKMsgModel.h
//  SHGO
//
//  Created by Alen on 2017/3/24.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKMsgModel : NSObject

@property (nonatomic, strong) NSString *ckId;
@property (nonatomic, strong) NSString *ckIdType;
@property (nonatomic, strong) NSString *ckOwn;
@property (nonatomic, strong) NSString *ckMemId;
@property (nonatomic, strong) NSString *ckName;
@property (nonatomic, strong) NSString *ckNumber;
@property (nonatomic, strong) NSString *ckPhone;
@property (nonatomic, strong) NSString *ckSex;
@property (nonatomic, strong) NSString *ckType;

-(instancetype)initWithInputData:(NSDictionary *)inputData;

@end
