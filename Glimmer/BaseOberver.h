//
//  BaseOberver.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/7.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDispatcher.h"
#import "CommandHandler.h"

@class EventCaptive;

@interface BaseOberver : NSObject
//唯一判断的标准（绑定的对象）
@property(retain,nonatomic)id delegate;
//是否还存活
@property(assign,nonatomic)BOOL isLive;
//init
-(instancetype)initWithTarget:(id)target;
-(void)noticeHandler:(EventCaptive*)event;
-(BOOL)match:(id)value;
-(void)free;

@end

//静态绑定
@interface CommandOberver : BaseOberver

@end

//第二种动态形式
@interface ClassOberver : BaseOberver

@end


