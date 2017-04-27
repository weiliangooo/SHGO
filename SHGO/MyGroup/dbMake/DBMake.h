//
//  DBMake.h
//  SHGO
//
//  Created by 魏亮 on 2017/4/26.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlaceModel;
@interface DBMake : NSObject

+(DBMake *)shareInstance;

-(void)upDatePlace:(NSMutableArray<PlaceModel*> *)data;
-(NSMutableArray<PlaceModel *> *)getPlaceHistory;

@end
