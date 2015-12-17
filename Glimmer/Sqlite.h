//
//  Sqlite.h
//  TechnicalSupport
//
//  Created by MikeRiy on 15/12/17.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface Sqlite : NSObject{
    @private
        sqlite3 *database;
}

@property(nonatomic,copy) NSString* liteFile;
//@property(nonatomic,strong) id delegate;
@property(nonatomic,assign) BOOL isopen;



-(BOOL)open:(NSString*)name;
-(BOOL)open;
-(void)close;
//建立表
-(BOOL)create:(NSString*)tableName values:(NSDictionary*)dic;
//语句执行
-(BOOL)exec:(NSString *) sql;
//原始
-(BOOL)remove:(NSString*)sql;
-(BOOL)insert:(NSString *)sql;
-(NSMutableArray*)select:(NSString *)sql;
-(BOOL)update:(NSString *)sql;


@end

//扩展
@interface Sqlite(MutableSqlite)

-(BOOL)insert:(NSDictionary*)dic table:(NSString*)name;
-(BOOL)update:(NSDictionary*)dic where:(NSDictionary*)keys table:(NSString*)name;
//
@end