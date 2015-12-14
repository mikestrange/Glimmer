//
//  EventDispatcher.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOberver.h"
#import "ICommand.h"

typedef NSString* EVENT_NAME;
typedef NSInteger EVENT_TYPE;
/*
//回执方法
typedef void(^EventMethod)(EventCaptive* event);

#define EventHandler(target, method) ^(EventCaptive* event){\
    [self performSelector:@selector(method) withObject:event];\
}
*/
#define DEF_NOTICE_TYPE 0

@class BaseOberver;
@class ICommand;
@class EventDispatcher;

@interface Event : NSObject
@property(retain,readonly,nonatomic) id data;
@property(assign,readonly,nonatomic) EVENT_NAME name;
@property(assign,readonly,nonatomic) EVENT_TYPE type;
@property(retain,nonatomic) EventDispatcher* target;
//
-(instancetype)initWithArgs:(EVENT_NAME)messageName target:(id)info messageType:(EVENT_TYPE)index;

@end


@interface EventDispatcher : NSObject
{
    @private
    NSMutableDictionary* noticeMap;
}

//可以自定义
-(void)addEventListener:(EVENT_NAME)notice oberver:(BaseOberver*)target;
//添加一个处理实例
-(void)addCommandListener:(EVENT_NAME)notice command:(id)target;
//添加一个处理类
-(void)addClassListener:(EVENT_NAME)notice classes:(Class)target;
//根据一个对象移除
-(void)removeEventListener:(EVENT_NAME)notice delegate:(id)target;
//判断
-(BOOL)hasEventListener:(EVENT_NAME)notice;
//发送消息
-(void)dispatchMessage:(Event*)event;

@end



