//
//  DBMake.m
//  SHGO
//
//  Created by 魏亮 on 2017/4/26.
//  Copyright © 2017年 Alen. All rights reserved.
//

#import "DBMake.h"
#import "FMDatabase.h"
#import "PlaceModel.h"

@implementation DBMake

+(DBMake *)shareInstance
{
    static DBMake *dbMakeInstace = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        if (dbMakeInstace == nil) {
            dbMakeInstace = [[self alloc] init];
        }

    });
    return dbMakeInstace;
}

-(FMDatabase *)myDB
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [docPath stringByAppendingString:@"/place.sqlite"];
    NSLog(@"dbpath == %@", dbPath);
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        return db;
    }
    return nil;
}

-(void)upDatePlace:(NSMutableArray<PlaceModel*> *)data
{
    [[self myDB] open];
    
    [[self myDB] executeUpdate:@"drop table if exists placetable;"];
    
    BOOL result = [[self myDB] executeUpdate:@"CREATE TABLE IF NOT EXISTS placetable (id integer PRIMARY KEY AUTOINCREMENT, cityname text NOT NULL, address text NOT NULL, detailaddress text NOT NULL, location text NOT NULL);"];
    
    if (result)
    {
        NSLog(@"再次创表成功");
        NSMutableArray<PlaceModel *> *array = [NSMutableArray array];
        array = [data mutableCopy];
        array = [self filterdPlaceData:array];
        for (PlaceModel *model in array)
        {
            [[self myDB] executeUpdate:@"INSERT INTO placetable (cityname, address, detailaddress, location) VALUES (?,?,?,?);",model.cityName,model.address,model.detailAddress,[MyHelperTool locationCoordinateToLocationString:model.location]];
        }
    }
    else
    {
        NSLog(@"再次创表失败");
    }
    
    [[self myDB] close];
}

-(NSMutableArray<PlaceModel *> *)getPlaceHistory
{
    [[self myDB] open];
    NSMutableArray<PlaceModel *> *array = [NSMutableArray array];
    FMResultSet *resultSet = [[self myDB] executeQuery:@"select * from placetable"];
    while ([resultSet next]) {
        PlaceModel *model = [[PlaceModel alloc] init];
        model.cityName = [resultSet stringForColumn:@"cityname"];
        model.address = [resultSet stringForColumn:@"address"];
        model.detailAddress = [resultSet stringForColumn:@"detailaddress"];
        model.location = [MyHelperTool locationStringToLocationCoordinate:[resultSet stringForColumn:@"location"]];
        [array insertObject:model atIndex:0];
    }
    [[self myDB] close];
    return [array mutableCopy];
}

-(NSMutableArray<PlaceModel *> *)filterdPlaceData:(NSMutableArray<PlaceModel *> *)dataSource
{
    for (int i = 0; i < dataSource.count; i++)
    {
        PlaceModel *model1 = [[PlaceModel alloc] init];
        model1 = dataSource[i];
        for (int j = i+1; j < dataSource.count ; j++)
        {
            PlaceModel *model2 = [[PlaceModel alloc] init];
            model2 = dataSource[j];
            if ([[MyHelperTool locationCoordinateToLocationString:model1.location] isEqualToString:[MyHelperTool locationCoordinateToLocationString:model2.location]])
            {
                [dataSource removeObjectAtIndex:j];
                break;
            }
        }
    }
    return dataSource;
}


@end
