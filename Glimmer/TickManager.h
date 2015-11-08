//
//  TickUtils.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/2.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义一个回执方法
#define tickHandler(target,method) ^{[target performSelector:@selector(method)];}
//声明一个方法属性
typedef void(^TickMethod)();
/*
 * 一个计时器，控制
 */
@interface TickManager : NSObject

//自定义
+(void)scheduled:(id)target function:(TickMethod)method selectId:(NSInteger)index
        interval:(NSTimeInterval)value repeats:(NSInteger)times;
//建立一次性计时器
+(void)scheduledOnce:(id)target function:(TickMethod)method interval:(NSTimeInterval)value;
//建立永久计时器
+(void)scheduledForever:(id)target function:(TickMethod)method interval:(NSTimeInterval)value;
//移除单位指定的一个计时器(selid一样都会被移除)
+(void)removeByTag:(id)target selId:(NSInteger)tag;
//移除包含该对象的所有时间计时器
+(void)removeByTarget:(id)target;

@end


//计时器携带的信息
@interface TickData : NSObject{
    @private
    NSTimer* _timer;
    TickMethod _method;
}
//
@property(assign) NSInteger selectId;
@property(retain,readonly) id target;
@property(assign,readonly) NSInteger runCount;

-(instancetype)initWithArgs:(id)info selId:(NSInteger)value function:(TickMethod)func
                   Interval:(NSTimeInterval)interval times:(NSInteger)count;

-(BOOL)matchSelectId:(NSInteger)value;

-(BOOL)matchTarget:(id)value;

@end