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
@synthesize moduleName = _moduleName;

-(void)registered:(FacedEmployer*)employer markId:(NSString*)name
{
    _faced = employer;
    _moduleName = name;
    _bindMap = [[NSMutableArray alloc] init];
    _dataMap = [[NSMutableDictionary alloc] init];
}

-(void)addBindto:(id<IBindVisitor>)target
{
    if(NONE != [_bindMap indexOfObject:target])
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
    if([_bindMap count] != EMPTY)
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
        id handler = [[classes alloc] init];
        [handler noticeHandler:event];
    } delegate:classes];
}

-(void)removeCommand:(NOTICE_NAME)name className:(Class)classes
{
    [self.faced removeEventListener:name delegate:classes];
}

-(BOOL)isEmpty
{
    return [_bindMap count] == EMPTY;
}

-(void)destroy
{
    
}


@end
