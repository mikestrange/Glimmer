//
//  BaseScene.m
//  Glimmer
//
//  Created by MikeRiy on 15/12/14.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "BaseScene.h"

@implementation BaseScene

-(instancetype)init{
    if(self = [super init]){
        [self initSceneMode];
    }
    return self;
}

//初始化模式
-(void)initSceneMode{
    self.scaleMode = SKSceneScaleModeAspectFill;
}

-(void)didMoveToView:(SKView *)view {
    [self onEnter:view];
}

-(void)willMoveFromView:(SKView *)view{
    [self onExit];
}

-(void)onEnter:(SKView*)view{
    
}

-(void)onExit{
    
}

@end
