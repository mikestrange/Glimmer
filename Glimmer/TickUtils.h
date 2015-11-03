//
//  TickUtils.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/2.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 * 一个计时器，控制
 */
@interface TickManager : NSObject

+(void)scheduled:(id)target function:(SEL)apply selId:(NSInteger)index interval:(NSTimeInterval)value repeats:(BOOL)boolean;
//移除单位指定的一个计时器(selid一样都会被移除)
+(void)removeScheduled:(id)target selId:(NSInteger)index;
//


@end


//计时器携带的信息
@interface TickData : NSObject

@end