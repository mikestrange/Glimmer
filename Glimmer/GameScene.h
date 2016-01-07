//
//  GameScene.h
//  MyGame
//

//  Copyright (c) 2015年 Mac_Tech. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
//#import <MediaPlayer/MediaPlayer.h>
#import "BaseScene.h"
#import "NetSocket.h"
#import "ActionUtils.h"
#import "DrawUtils.h"
#import "MoreTableView.h"
#import "SoundManager.h"
#import "TickManager.h"
#import "TrimString.h"
#import "DownLoader.h"
#import "QuickHandler.h"
#import "FacedEmployer.h"
#import "EventDispatcher.h"
#import "NetSocket.h"
#import "ByteArray.h"
#import "MapInfo.h"
#import "MapController.h"
#import "MovieClip.h"
#import "EventFrame.h"
#import "Video.h"

@interface GameScene : BaseScene<ICommand>

@property(strong,nonatomic)MapController* controller;
@property(assign,nonatomic)CGPoint beginPoint;

@end
