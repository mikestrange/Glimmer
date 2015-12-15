//
//  MovieClip.h
//  TechnicalSupport
//
//  Created by MikeRiy on 15/12/15.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieClip : UIImageView

@property(nonatomic,strong) NSArray<NSString*> *frames;
@property(nonatomic,assign) NSInteger currentFrame;
@property(nonatomic,strong) NSTimer* timer;

-(instancetype)initWithVector:(NSArray*)vector;

-(void)play;

-(void)play:(NSTimeInterval)time;

-(BOOL)isPlay;

-(void)stop;

-(void)gotoAndStop:(NSInteger)value;

-(void)gotoAndPlay:(NSInteger)value;

//多维
@property(nonatomic,copy) NSString* actionName;
@property(nonatomic,strong) NSMutableDictionary* actionMap;

-(void)addActionFrames:(NSArray*)vector name:(NSString*)actionName;

-(void)currentAction:(NSString*)actionName;

-(BOOL)hasAction:(NSString*)actionName;

-(void)removeAction:(NSString*)actionName;

-(void)gotoAndPlay:(NSString*)actionName beginIndex:(NSInteger)value;

-(void)gotoAndStop:(NSString*)actionName currentIndex:(NSInteger)value;

-(void)playAction:(NSString*)actionName;

@end

