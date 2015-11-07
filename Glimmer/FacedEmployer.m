//
//  FacedDelivery.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "FacedEmployer.h"

static FacedEmployer* _instance;

@implementation FacedEmployer

+(instancetype)getInstance
{
    if(nil == _instance){
        _instance = [[FacedEmployer alloc] init];
    }
    return _instance;
}

-(instancetype)init
{
    if(self = [super init]){
        moduleMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)addCommandVector:(NSArray*)vector command:(id<CommandHandler>)target
{
    for(NSString* name in vector)
    {
        [self addCommandListener:name command:target];
    }
}

-(void)addClassVector:(NSArray*)vector classes:(Class)target
{
    for(NSString* name in vector)
    {
        [self addClassListener:name classes:target];
    }
}

-(void)removeNotices:(NSArray*)vector delegate:(id)target
{
    for(NSString* name in vector)
    {
        [self removeEventListener:name delegate:target];
    }
}

-(void)sendMessage:(NOTICE_NAME)name info:(id)data type:(NOTICE_TYPE)index
{
    [self dispatchMessage:[[EventCaptive alloc] initWithArgs:name target:data messageType:index]];
}

-(void)sendMessage:(NOTICE_NAME)name info:(id)data
{
    [self dispatchMessage:[[EventCaptive alloc] initWithArgs:name target:data messageType:DEF_NOTICE_TYPE]];
}

-(void)sendMessage:(NOTICE_NAME)name
{
    [self dispatchMessage:[[EventCaptive alloc] initWithArgs:name target:nil messageType:DEF_NOTICE_TYPE]];
}

-(void)sendMessage:(NOTICE_NAME)name type:(NOTICE_TYPE)index
{
    [self dispatchMessage:[[EventCaptive alloc] initWithArgs:name target:nil messageType:index]];
}

@end
