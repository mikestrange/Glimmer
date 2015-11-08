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

-(void)noticeHandler:(EventCaptive*)event
{
    
}

@end


#pragma CommandOberver
@implementation CommandOberver

-(void)noticeHandler:(EventCaptive*)event
{
    id<CommandHandler> command = (id<CommandHandler>)self.delegate;
    [command noticeHandler:event];
}

@end

#pragma ClassOberver
@implementation ClassOberver

-(void)noticeHandler:(EventCaptive*)event
{
    Class Command = (Class)self.delegate;
    id<CommandHandler> command = [[Command alloc] init];
    [command noticeHandler:event];
}

@end

#pragma MethodOberver
@implementation MethodOberver

@synthesize method;

-(instancetype)initWithMethod:(id)target methodFunction:(EventMethod)function
{
    if(self = [super initWithTarget:target]){
        self.method = function;
    }
    return self;
}

-(void)noticeHandler:(EventCaptive*)event
{
    self.method(event);
}

@end
