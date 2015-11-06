//
//  ModuleDelivery.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "ModuleDelivery.h"
#import "ICommandHandler.h"

@implementation ModuleDelivery

static NSUInteger EMPTY = 0;
static NSUInteger NONE = -1;

@synthesize faced = _faced;

-(instancetype)initWithFaced:(FacedEmployer*)employer
{
    if(self = [super init])
    {
        [self registered:employer];
    }
    return self;
}

-(void)registered:(FacedEmployer*)employer
{
    _bindMap = [[NSMutableArray alloc] init];
    _dataMap = [[NSMutableDictionary alloc] init];
    _faced = employer;
    [_faced addModule:self];
}

-(void)addBindto:(id<IBindVisitor>)target
{
    if(_bindMap && NONE!=[_bindMap indexOfObject:target])
    {
        //add Notices
        NSArray* list = [target getNoticeArray];
        for(NSString* key in list){
            [self.faced addEventListener:key observer:MessageHandler(target,noticeHandler:)
                                delegate:target];
        }
        //binding
        [_bindMap addObject:target];
        [target launch];
    }
}

-(void)removeBindto:(id<IBindVisitor>)target
{
    if(_bindMap && [_bindMap count] != EMPTY)
    {
        NSUInteger index = [_bindMap indexOfObject:target];
        if(NONE != index){
            //remove Notices
             NSArray* list = [target getNoticeArray];
            for(NSString* key in list){
                [self.faced removeEventListener:key delegate:target];
            }
            //delete
            [_bindMap removeObjectAtIndex:index];
            [target free];
        }
    }
}

-(void)addCommand:(NOTICE_NAME)name className:(Class)classes
{
    [self.faced addEventListener:name observer:^(EventMessage *event) {
       // classes* cmd = [classes new];
       // [cmd noticeHandler:event];
    } delegate:classes];
}

-(void)removeCommand:(NOTICE_NAME)name className:(Class)classes
{
    [self.faced removeEventListener:name delegate:classes];
}

-(void)commandHandler:(EventMessage*)event
{
    
}

-(BOOL)isEmpty
{
    if(_bindMap && [_bindMap count] == EMPTY){
        return YES;
    }
    return NO;
}

-(void)destroy
{
    
}

-(void)dealloc
{
    [self destroy];
}

@end
