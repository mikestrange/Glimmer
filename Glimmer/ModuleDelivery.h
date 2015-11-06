//
//  ModuleDelivery.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBindVisitor.h"
#import "IDataTable.h"
#import "FacedEmployer.h"

/*
 *ModuleDelivery的作用是让逻辑和职责更好的分开，他新增了任务模式
 **/
@class FacedEmployer;

@interface ModuleDelivery : NSObject{
    @protected
    NSMutableArray* _bindMap;
    NSMutableDictionary* _dataMap;
}

@property(strong,readonly,nonatomic) FacedEmployer* faced;
@property(copy,readonly,nonatomic) NSString* moduleName;

-(void)registered:(FacedEmployer*)employer markId:(NSString*)name;
//
-(void)addBindto:(id<IBindVisitor>)target;
-(void)removeBindto:(id<IBindVisitor>)target;
//
-(void)addCommand:(NOTICE_NAME)name className:(Class)classes;
-(void)removeCommand:(NOTICE_NAME)name className:(Class)classes;
//
-(BOOL)isEmpty;
-(void)destroy;

@end
