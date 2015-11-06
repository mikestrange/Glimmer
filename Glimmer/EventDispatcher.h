//
//  EventDispatcher.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString* NOTICE_NAME;
typedef NSInteger NOTICE_TYPE;

//EventMessage-----------
@interface EventMessage : NSObject
@property(copy,readonly,nonatomic) NOTICE_NAME name;
@property(assign,readonly,nonatomic) NOTICE_TYPE type;
@property(retain,readonly,nonatomic) id data;
//
-(instancetype)initWithArgs:(NOTICE_NAME)messageName target:(id)info messageType:(NOTICE_TYPE)index;
@end

//消息传递方式
#define MessageHandler(target, method) ^(EventMessage* event){\
    [target performSelector:@selector(method) withObject:event];\
}
//消息传递的类型
typedef void(^MessageMethod)(EventMessage* event);

//EventDispatcher------------
@interface EventDispatcher : NSObject{
    @private
    NSMutableDictionary* noticeMap;
}

-(void)addEventListener:(NOTICE_NAME)notice observer:(MessageMethod)method delegate:(id)target;

-(void)removeEventListener:(NOTICE_NAME)notice delegate:(id)target;

-(void)dispatchMessage:(EventMessage*)event;

-(BOOL)hasEventListener:(NOTICE_NAME)notice;

@end

//EventObserver-----------
@interface EventObserver : NSObject

@property(retain,readonly,nonatomic) MessageMethod function;
@property(retain,readonly,nonatomic) id delegate;
@property(assign,readonly,nonatomic) BOOL isFree;


-(instancetype)initWithTarget:(MessageMethod)method delegate:(id)target;
-(void)eventHandler:(EventMessage*)event;
-(BOOL)match:(id)target;
-(void)free;

@end


