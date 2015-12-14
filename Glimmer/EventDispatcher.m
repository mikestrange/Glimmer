//
//  EventDispatcher.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "EventDispatcher.h"

@implementation EventDispatcher

static NSUInteger NO_EMPTY = 0;

-(instancetype)init
{
    if(self = [super init]){
        noticeMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)addEventListener:(EVENT_NAME)notice oberver:(BaseOberver*)target
{
    NSMutableArray* list = [noticeMap objectForKey:notice];
    if(!list){
        list = [[NSMutableArray alloc] init];
        [list addObject:target];
        [noticeMap setObject:list forKey:notice];
    }else{
        //NSUInteger index = [list indexOfObject:target.delegate];
        //if(-1 != index){
            [list addObject:target];
        //}
    }
}

-(void)addCommandListener:(EVENT_NAME)notice command:(id)target
{
    [self addEventListener:notice oberver:[[CommandOberver alloc] initWithTarget:target]];
}

-(void)addClassListener:(EVENT_NAME)notice classes:(Class)target
{
    [self addEventListener:notice oberver:[[ClassOberver alloc] initWithTarget:target]];
}

-(void)removeEventListener:(EVENT_NAME)notice delegate:(id)target
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
-(void)dispatchMessage:(Event*)event
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
                [oberver eventHandler:event];
            }
        }
    }
}

-(BOOL)hasEventListener:(EVENT_NAME)notice
{
    return [noticeMap objectForKey:notice];
}


@end


#pragma EventCaptive
@implementation Event

@synthesize name = _name;
@synthesize type = _type;
@synthesize data = _data;

-(instancetype)initWithArgs:(EVENT_NAME)messageName target:(id)info messageType:(EVENT_TYPE)index
{
    if(self = [super init]){
        _name = messageName;
        _data = info;
        _type = index;
    }
    return self;
}

@end

