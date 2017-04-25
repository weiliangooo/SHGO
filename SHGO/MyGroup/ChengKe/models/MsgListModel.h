//
//  MsgListModel.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/25.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MsgModel;
@interface MsgListModel : NSObject

@property (nonatomic, strong)NSMutableArray<MsgModel *> *msgModels;

-(instancetype)initWith:(NSArray *)dataSource;

@end


@interface MsgModel : NSObject

@property (nonatomic, copy)NSString *msgId;

@property (nonatomic, copy)NSString *msgContent;

@property (nonatomic, copy)NSString *msgMemberId;

@property (nonatomic, copy)NSString *msgWebUrl;

@property (nonatomic, copy)NSString *sendTime;

@property (nonatomic, assign)BOOL isRead;

-(instancetype)initWithData:(NSDictionary *)dataSource;

@end
