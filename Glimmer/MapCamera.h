//
//  MapCamera.h
//  Glimmer
//  依赖存在，所以弱引用
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapController.h"

@class MapController;

@interface MapCamera : NSObject

@property(nonatomic,strong)MapController* controller;

-(instancetype)initWithTarget:(MapController*)target;

@end
