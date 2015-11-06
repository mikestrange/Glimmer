//
//  FacedDelivery.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "FacedEmployer.h"

@implementation FacedEmployer


-(void)addModule:(ModuleDelivery*)target
{
    
}

-(void)removeModule:(ModuleDelivery*)target
{
    
}

-(void)sendMessage:(NOTICE_NAME)name info:(id)data type:(NOTICE_TYPE)index
{
    [self dispatchMessage:[[EventMessage alloc] initWithArgs:name target:data messageType:index]];
}

@end
