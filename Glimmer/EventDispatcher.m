//
//  EventDispatcher.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "EventDispatcher.h"
#import "ICommandHandler.h"

@implementation EventDispatcher

static NSUInteger NONE = -1;
static NSUInteger NO_EMPTY = 0;

-(instancetype)init
{
    if(self = [super init]){
        noticeMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)addEventListener:(NOTICE_NAME)notice observer:(MessageMethod)method delegate:(id)target
{
    NSMutableArray* list = [noticeMap objectForKey:notice];
    if(!list){
        list = [[NSMutableArray alloc] init];
        [list addObject:[[EventObserver alloc] initWithTarget:method delegate:target]];
        [noticeMap setObject:list forKey:notice];
    }else{
        NSUInteger index = [list indexOfObject:target];
        if(NONE != index){
            [list addObject:[[EventObserver alloc] initWithTarget:method delegate:target]];
        }
    }
}

-(void)removeEventListener:(NOTICE_NAME)notice delegate:(id)target
{
    NSMutableArray* list = [noticeMap objectForKey:notice];
    if(list){
        for(EventObserver* data in list){
            if([data match:target]){
                [data free];
                [list removeObject:data];
                break;
            }
        }
        if(NO_EMPTY == [list count]){
            [noticeMap removeObjectForKey:notice];
        }
    }
}

-(void)dispatchMessage:(EventMessage*)event
{
    NSMutableArray* list = [noticeMap objectForKey:[event name]];
    if(list)
    {
        NSMutableArray* vector = [NSMutableArray arrayWithArray:list];
        for(EventObserver* data in vector){
            [data eventHandler:event];
        }
    }
}

-(BOOL)hasEventListener:(NOTICE_NAME)notice
{
    return [noticeMap objectForKey:notice];
}

@end


//EventObserver==========================
#pragma class EventObserver

@implementation EventObserver

@synthesize function = _function;
@synthesize isFree = _isFree;
@synthesize delegate = _delegate;

-(instancetype)initWithTarget:(MessageMethod)method delegate:(id)target
{
    if(self = [super init])
    {
        _function = method;
        _delegate = target;
        _isFree = NO;
    }
    return self;
}

-(BOOL)match:(id)target
{
    return self.delegate == target;
}

-(void)free
{
    _isFree = YES;
}

-(void)eventHandler:(EventMessage*)event
{
    if(!self.isFree){
        self.function(event);
    }
}

@end


//EventMessage==========================
#pragma class EventMessage

@implementation EventMessage

@synthesize name = _name;
@synthesize type = _type;
@synthesize data = _data;

-(instancetype)initWithArgs:(NOTICE_NAME)messageName target:(id)info messageType:(NOTICE_TYPE)index
{
    if(self = [super init]){
        _name = messageName;
        _data = info;
        _type = index;
    }
    return self;
}

@end
