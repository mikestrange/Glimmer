//
//  FacedDelivery.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDispatcher.h"
#import "ModuleDelivery.h"

@class ModuleDelivery;

@interface FacedEmployer : EventDispatcher

//添加模块
-(void)addModule:(ModuleDelivery*)target;
//移除模块
-(void)removeModule:(ModuleDelivery*)target;
//发送消息
-(void)sendMessage:(NOTICE_NAME)name info:(id)data type:(NOTICE_TYPE)index;

@end
