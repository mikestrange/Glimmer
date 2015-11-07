//
//  TickUtils.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/2.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "TickManager.h"


static NSMutableArray* _tickList = nil;
//
static const NSInteger NONE = 0;
static const NSInteger DEF_TAG = 1;
static const NSInteger DEF_TIMES = 1;
static const NSInteger DEF_FOREVER_TIMES = -1;

@implementation TickManager

+(NSMutableArray*)getTickPool
{
    if(_tickList == nil){
        _tickList = [[NSMutableArray alloc] init];
    }
    return _tickList;
}

+(void)removeByTag:(id)target selId:(NSInteger)tag
{
    const NSMutableArray* list = [TickManager getTickPool];
    for(TickData* data in list){
        if([data matchSelectId:tag] && [data matchTarget:target]){
            [TickManager removeTick:data];
        }
    }
}

+(void)removeByTarget:(id)target
{
    const NSMutableArray* list = [TickManager getTickPool];
    for(TickData* data in list){
        if([data matchTarget:target]){
            [TickManager removeTick:data];
        }
    }
}

//private
+(void)removeTick:(id)target
{
    [target stop];
    [[TickManager getTickPool] removeObject:target];
}

//计时器必须的一个入口
+(void)scheduled:(id)target function:(TickMethod)method selectId:(NSInteger)index
        interval:(NSTimeInterval)value repeats:(NSInteger)times;
{
   //添加队列
    [[TickManager getTickPool] addObject:[[TickData alloc] initWithArgs:NULL selId:0 function:method Interval:value times:times]];
}

+(void)scheduledOnce:(id)target function:(TickMethod)method interval:(NSTimeInterval)value
{
    [TickManager scheduled:target function:method selectId:DEF_TAG interval:value
                repeats:DEF_TIMES];
}

+(void)scheduledForever:(id)target function:(TickMethod)method interval:(NSTimeInterval)value
{
    [TickManager scheduled:target function:method selectId:DEF_TAG interval:value
                   repeats:DEF_FOREVER_TIMES];
}

@end



//计时器信息
@implementation TickData

@synthesize target;
@synthesize selectId;
@synthesize runCount;

-(instancetype)initWithArgs:(id)info selId:(NSInteger)value function:(TickMethod)func
                   Interval:(NSTimeInterval)interval times:(NSInteger)count;
{
    if(self=[super init])
    {
        target = info;
        selectId = value;
        runCount = count;
        _method = func;
        //start
        [self start:interval];
    }
    return self;
}

-(BOOL)matchSelectId:(NSInteger)value
{
    return value == self.selectId;
}

-(BOOL)matchTarget:(id)value
{
    return self.target == value;
}

//private
-(void)start:(NSTimeInterval)interval
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                      target:self
                                                    selector:@selector(onTimerHandler)
                                                    userInfo:nil repeats:YES];
    //[[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)onTimerHandler
{
    if(self.runCount <= NONE){
        [self callback];
    }else{
        [self callback];
        if(--runCount <= NONE){
            [TickManager removeTick:self];
        }
    }
}

//可以把本事作为参数传过去
-(void)callback
{
    _method();
}

-(void)stop
{
    if (_timer && [_timer isValid])
    {
        [_timer invalidate];
    }
}

@end







