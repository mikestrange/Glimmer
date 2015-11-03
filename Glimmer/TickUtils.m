//
//  TickUtils.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/2.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "TickUtils.h"

static NSMutableArray* _tickList = nil;

@implementation TickManager


+(void)removeScheduled:(id)target selId:(NSInteger)index
{

}

//@selector(apply)
+(void)scheduled:(id)target function:(SEL)apply selId:(NSInteger)index interval:(NSTimeInterval)value repeats:(BOOL)boolean
{
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:value target:target selector:apply
                                              userInfo:nil repeats:boolean];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}



@end
