//
//  MapCamera.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "MapCamera.h"

@implementation MapCamera

@synthesize controller;

-(instancetype)initWithTarget:(MapController*)target
{
    if(self = [super init]){
        self.controller = target;
    }
    return self;
}

@end
