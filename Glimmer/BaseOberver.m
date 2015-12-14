//
//  BaseOberver.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/7.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "BaseOberver.h"

@implementation BaseOberver

@synthesize isLive;
@synthesize delegate;

-(instancetype)initWithTarget:(id)target
{
    if(self = [super init])
    {
        self.delegate = target;
        self.isLive = YES;
    }
    return self;
}

-(BOOL)match:(id)value
{
    return self.delegate == value;
}

-(void)free
{
    self.isLive = NO;
}

-(void)eventHandler:(Event*)event
{
    
}

@end


#pragma CommandOberver
@implementation CommandOberver

-(void)eventHandler:(Event*)event
{
    id<ICommand> command = (id<ICommand>)self.delegate;
    [command eventHandler:event];
}

@end

#pragma ClassOberver
@implementation ClassOberver

-(void)eventHandler:(Event*)event
{
    Class Command = (Class)self.delegate;
    id<ICommand> command = [[Command alloc] init];
    [command eventHandler:event];
}

@end

