//
//  BaseScene.h
//  Glimmer
//
//  Created by MikeRiy on 15/12/14.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "EventFrame.h"

@interface BaseScene : SKScene

-(void)onEnter:(SKView*)view;
-(void)onExit;


@end
