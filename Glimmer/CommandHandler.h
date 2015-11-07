//
//  ICommandHandler.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDispatcher.h"

@class EventCaptive;
@protocol CommandHandler<NSObject>

@required
-(void)noticeHandler:(EventCaptive*)event;

@end