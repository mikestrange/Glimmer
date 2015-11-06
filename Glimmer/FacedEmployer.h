//
//  FacedDelivery.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDispatcher.h"
#import "ModuleDelivery.h"

@class ModuleDelivery;

@interface FacedEmployer : EventDispatcher{
    @protected
    NSMutableDictionary* moduleMap;
}
//使用一个单列
+(instancetype)getInstance;
//是否存在
-(BOOL)hasModule:(NSString*)value;
//添加模块
-(void)addModule:(ModuleDelivery*)target markId:(NSString*)value;
//移除模块
-(void)removeModule:(NSString*)value;
//发送消息
-(void)sendMessage:(NOTICE_NAME)name info:(id)data type:(NOTICE_TYPE)index;
//发送消息2
-(void)sendMessage:(NOTICE_NAME)name info:(id)data;
//发送消息3
-(void)sendMessage:(NOTICE_NAME)name;
@end
