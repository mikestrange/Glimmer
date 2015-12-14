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

-(void)addCommandVector:(NSArray*)vector command:(id<ICommand>)target
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

#pragma sendMessage
-(void)sendMessage:(EVENT_NAME)name info:(id)data type:(EVENT_TYPE)index
{
    [self dispatchMessage:[[Event alloc] initWithArgs:name target:data messageType:index]];
}

-(void)sendMessage:(EVENT_NAME)name info:(id)data
{
    [self dispatchMessage:[[Event alloc] initWithArgs:name target:data messageType:DEF_NOTICE_TYPE]];
}

-(void)sendMessage:(EVENT_NAME)name
{
    [self dispatchMessage:[[Event alloc] initWithArgs:name target:nil messageType:DEF_NOTICE_TYPE]];
}

-(void)sendMessage:(EVENT_NAME)name type:(EVENT_TYPE)index
{
    [self dispatchMessage:[[Event alloc] initWithArgs:name target:nil messageType:index]];
}

@end
