//
//  EventDispatcher.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOberver.h"
#import "CommandHandler.h"

typedef NSString* NOTICE_NAME;
typedef NSInteger NOTICE_TYPE;

#define DEF_NOTICE_TYPE 0

@class BaseOberver;
@class EventCaptive;
@class EventDispatcher;

@interface EventCaptive : NSObject
@property(retain,readonly,nonatomic) id data;
@property(copy,readonly,nonatomic) NOTICE_NAME name;
@property(assign,readonly,nonatomic) NOTICE_TYPE type;
@property(retain,nonatomic) EventDispatcher* target;
//
-(instancetype)initWithArgs:(NOTICE_NAME)messageName target:(id)info messageType:(NOTICE_TYPE)index;

@end


@interface EventDispatcher : NSObject
{
    @private
    NSMutableDictionary* noticeMap;
}

//可以自定义
-(void)addEventListener:(NOTICE_NAME)notice oberver:(BaseOberver*)target;
//添加一个处理实例
-(void)addCommandListener:(NOTICE_NAME)notice command:(id/*<CommandHandler>*/)target;
//添加一个处理类
-(void)addClassListener:(NOTICE_NAME)notice classes:(Class)target;
//根据一个对象移除
-(void)removeEventListener:(NOTICE_NAME)notice delegate:(id)target;

-(void)dispatchMessage:(EventCaptive*)event;

-(BOOL)hasEventListener:(NOTICE_NAME)notice;

-(BOOL)hasEventListener:(NOTICE_NAME)notice delegate:(id)target;

@end



