//
//  Sqlite.m
//  TechnicalSupport
//
//  Created by MikeRiy on 15/12/17.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "Sqlite.h"

@implementation Sqlite

@synthesize liteFile;
@synthesize isopen;

-(BOOL)open:(NSString*)name{
    [self findLite:name];
    return [self open];
}

-(BOOL)open
{
    if(self.isopen){
        NSLog(@"is open");
        return YES;
    }
    int succeed = sqlite3_open([self.liteFile UTF8String], &database);
    if(succeed == SQLITE_OK){
        self.isopen = YES;
        NSLog(@"open succeed");
    }else{
        NSLog(@"open error");
        sqlite3_close(database);
    }
    return succeed == SQLITE_OK;
}

-(void)close{
    if(self.isopen){
        self.isopen = NO;
        sqlite3_close(database);
    }
}

//设置名称
-(NSString*)findLite:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [[NSString alloc] initWithFormat:@"%@.sqlite3", name];
    self.liteFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    return self.liteFile;
}

-(BOOL)create:(NSString*)tableName values:(NSDictionary*)dic
{
    //NSString *str = @"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, address TEXT, num TEXT)";
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"CREATE TABLE IF NOT EXISTS %@(ID INTEGER PRIMARY KEY AUTOINCREMENT,", tableName];
    NSArray* list = [dic allKeys];
    for(int i = 0;i<list.count;i++){
        NSString* name = [list objectAtIndex:i];
        NSString* type = [dic objectForKey:name];
        if(i==list.count-1){
            [sql appendFormat:@" %@ %@", name, type];
        }else{
            [sql appendFormat:@" %@ %@,", name, type];
        }
    }
    [sql appendString:@")"];
    //
    [self exec:sql];
    return YES;
}

//执行语句
-(BOOL)exec:(NSString *) sql
{
    // create table if not exists dataCache (dkey varchar(100) PRIMARY KEY, dvalue TEXT, utime timestamp)
    char *errorMsg;
    int succeed = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg);
    if (succeed == SQLITE_OK) {
        NSLog(@"exec succeed");
    }else{
        NSLog(@"exec error: %s",errorMsg);
    }
    return succeed == SQLITE_OK;
}

//删除
-(BOOL)remove:(NSString*)sql
{
    //DELETE FROM tableName WHERE name = '张三'
    sqlite3_stmt * statement;
    int succeed = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
    if (succeed == SQLITE_OK) {
        int success = sqlite3_step(statement);
        NSLog(@"delete succeed:%i", success);
    }else{
        NSLog(@"delete error");
    }
    sqlite3_finalize(statement);
    return succeed == SQLITE_OK;
}

//插入
-(BOOL)insert:(NSString *)sql
{
    //INSERT INTO 'table' (key1,key2,key3) VALUES ('value1','value2','value3');
    char *errorMsg;
    int succeed = sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg);
    if (succeed == SQLITE_OK) {
        NSLog(@"insert succeed");
    }else {
        NSLog(@"insert error: %s",errorMsg);
        NSLog(@"insert error: %@",sql);
    }
    return succeed == SQLITE_OK;
}

//查找
-(NSMutableArray*)select:(NSString *)sql
{
    //SELECT LastName,FirstName FROM Persons
    NSMutableArray *list;
    sqlite3_stmt * statement;
    int succeed = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
    if (succeed == SQLITE_OK) {
        list = [[NSMutableArray alloc] init];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //gets
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
            
            int money = sqlite3_column_int(statement, 2);
            
            NSLog(@"name:%@  money:%d",nsNameStr,money);
        }
    }
    return list;
}

//更新
-(BOOL)update:(NSString *)sql
{
    //UPDATE tableName SET address = '骊山er', City = 'Nanjing' WHERE name = '王者'
    sqlite3_stmt * statement;
    int succeed = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
    if (succeed == SQLITE_OK) {
        int success = sqlite3_step(statement);
        NSLog(@"update succeed:%i", success);
    }else{
        NSLog(@"update error:%@",sql);
    }
    sqlite3_finalize(statement);
    return succeed == SQLITE_OK;
}

@end



@implementation Sqlite(MutableSqlite)
//扩展
-(BOOL)insert:(NSDictionary*)dic table:(NSString*)name
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"INSERT INTO %@ ",name];
    //keys
    NSArray* keys = [dic allKeys];
    for(int i = 0;i<keys.count;i++){
        NSString* key = [keys objectAtIndex:i];
        if(keys.count==1){
            [sql appendFormat:@"(%@)",key];
        }else if(i==0){
            [sql appendFormat:@"(%@,",key];
        }else if(i == keys.count-1){
            [sql appendFormat:@" %@)",key];
        }else{
            [sql appendFormat:@" %@,",key];
        }
    }
    //
    [sql appendString:@" VALUES "];
    //values
    NSArray* values = [dic allValues];
    for(int i = 0;i<values.count;i++){
        NSString* value = [values objectAtIndex:i];
        if(values.count==1){
            [sql appendFormat:@"('%@')",value];
        }else if(i==0){
            [sql appendFormat:@"('%@',",value];
        }else if(i == values.count-1){
            [sql appendFormat:@" '%@')",value];
        }else{
            [sql appendFormat:@" '%@',",value];
        }
    }
    return [self insert:sql];
}

-(BOOL)update:(NSDictionary*)dic where:(NSDictionary*)rules table:(NSString*)name
{
    //NSString *sql = [NSString stringWithFormat:@"UPDATE PERSONINFO SET address = '骊山er' WHERE name = '王者'"];
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"UPDATE %@ SET ",name];
    NSArray* keys = [dic allKeys];
    for(int i = 0;i<keys.count;i++){
        NSString* key = [keys objectAtIndex:i];
        NSString* value = [dic objectForKey:key];
        if(keys.count==1){
            [sql appendFormat:@"%@ = '%@'", key, value];
        }else if(i == keys.count-1){
            [sql appendFormat:@"%@ = '%@'", key, value];
        }else{
            [sql appendFormat:@"%@ = '%@',", key, value];
        }
    }
    //
    [sql appendString:@" WHERE "];
    //rule
    NSArray* rule_list = [rules allKeys];
    for(int i = 0;i<rule_list.count;i++){
        NSString* key = [rule_list objectAtIndex:i];
        NSString* value = [rules objectForKey:key];
        if(rule_list.count==1){
            [sql appendFormat:@"%@ = '%@'", key, value];
        }else if(i == rule_list.count-1){
            [sql appendFormat:@"%@ = '%@'", key, value];
        }else{
            [sql appendFormat:@"%@ = '%@',", key, value];
        }
    }
    
    return [self update:sql];
}
//
@end