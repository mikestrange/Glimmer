//
//  FacedDelivery.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDispatcher.h"
#import "CommandHandler.h"

@interface FacedEmployer : EventDispatcher
{
    @protected
    NSMutableDictionary* moduleMap;
}
//使用一个单列
+(instancetype)getInstance;
//添加消息队列
-(void)addCommandVector:(NSArray*)vector command:(id<CommandHandler>)target;
//添加命令队列
-(void)addClassVector:(NSArray*)vector classes:(Class)target;
//移除消息队列
-(void)removeNotices:(NSArray*)vector delegate:(id)target;
#pragma 发送消息
//发送消息
-(void)sendMessage:(NOTICE_NAME)name info:(id)data type:(NOTICE_TYPE)index;
//发送消息2
-(void)sendMessage:(NOTICE_NAME)name info:(id)data;
//发送消息3
-(void)sendMessage:(NOTICE_NAME)name;
//发送消息4
-(void)sendMessage:(NOTICE_NAME)name type:(NOTICE_TYPE)index;
@end
