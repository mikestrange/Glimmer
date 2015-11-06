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

-(BOOL)hasModule:(NSString*)value
{
    return [moduleMap objectForKey:value];
}

-(void)addModule:(ModuleDelivery*)target markId:(NSString*)value
{
    [moduleMap setObject:target forKey:value];
    [target registered:self markId:value];
}

-(void)removeModule:(NSString*)value
{
    ModuleDelivery* data = [moduleMap objectForKey:value];
    if(data)
    {
        [moduleMap removeObjectForKey:value];
        [data destroy];
    }
}

-(void)sendMessage:(NOTICE_NAME)name info:(id)data type:(NOTICE_TYPE)index
{
    [self dispatchMessage:[[EventMessage alloc] initWithArgs:name target:data messageType:index]];
}

-(void)sendMessage:(NOTICE_NAME)name info:(id)data
{
    [self dispatchMessage:[[EventMessage alloc] initWithArgs:name target:data messageType:DEF_NOTICE_TYPE]];
}

-(void)sendMessage:(NOTICE_NAME)name
{
    [self dispatchMessage:[[EventMessage alloc] initWithArgs:name target:nil messageType:DEF_NOTICE_TYPE]];
}

@end
