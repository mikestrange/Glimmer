//
//  EventDispatcher.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "EventDispatcher.h"

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

-(void)addEventListener:(NOTICE_NAME)notice oberver:(BaseOberver*)target
{
    NSMutableArray* list = [noticeMap objectForKey:notice];
    if(!list){
        list = [[NSMutableArray alloc] init];
        [list addObject:target];
        [noticeMap setObject:list forKey:notice];
    }else{
        NSUInteger index = [list indexOfObject:target.delegate];
        if(NONE != index){
            [list addObject:target];
        }
    }
}

-(void)addMethodListener:(NOTICE_NAME)notice method:(EventMethod)function delegate:(id)target
{
    [self addEventListener:notice oberver:[[MethodOberver alloc] initWithMethod:target methodFunction:function]];
}

-(void)addCommandListener:(NOTICE_NAME)notice command:(id)target
{
    [self addEventListener:notice oberver:[[CommandOberver alloc] initWithTarget:target]];
}

-(void)addClassListener:(NOTICE_NAME)notice classes:(Class)target
{
    [self addEventListener:notice oberver:[[ClassOberver alloc] initWithTarget:target]];
}

-(void)removeEventListener:(NOTICE_NAME)notice delegate:(id)target
{
    NSMutableArray* list = [noticeMap objectForKey:notice];
    if(list){
        for(BaseOberver* data in list){
            if([data match:target]){
                [data free];
                [list removeObject:data];
                break;
            }
        }
        if(NO_EMPTY == [list count]){
            [noticeMap removeObjectForKey:notice];
            //NSLog(@"Empty:%@",notice);
        }
    }
}

//执行
-(void)dispatchMessage:(EventCaptive*)event
{
    NSMutableArray* list = [noticeMap objectForKey:[event name]];
    if(list)
    {
        //传入自身
        event.target = self;
        //拷贝
        NSMutableArray* vector = [NSMutableArray arrayWithArray:list];
        //派发
        for(BaseOberver* oberver in vector)
        {
            if(oberver.isLive){
                [oberver noticeHandler:event];
            }
        }
    }
}

-(BOOL)hasEventListener:(NOTICE_NAME)notice
{
    return [noticeMap objectForKey:notice];
}

-(BOOL)hasEventListener:(NOTICE_NAME)notice delegate:(id)target
{
    NSMutableArray* list = [noticeMap objectForKey:notice];
    if(list)
    {
        for(BaseOberver* data in list){
            if([data match:target]) return YES;
        }
    }
    return NO;
}


@end


#pragma EventCaptive
@implementation EventCaptive

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

