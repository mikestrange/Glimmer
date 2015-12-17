//
//  MovieClip.m
//  TechnicalSupport
//
//  Created by MikeRiy on 15/12/15.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "MovieClip.h"

@implementation MovieClip

@synthesize frames;
@synthesize currentFrame;

static const NSTimeInterval INTERVAL_TIME = .1;
static const NSInteger NONE = 0;

-(instancetype)init{
    if(self = [super init]){
        self.currentFrame = -1;
    }
    return self;
}

-(instancetype)initWithVector:(NSArray*)vector{
    if(self = [self init]){
        self.frames = vector;
        [self play];
        //自适应图片宽高比例
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(instancetype)initWithVector:(NSArray*)vector width:(NSInteger)a1 height:(NSInteger)a2{
    if(self = [self initWithVector:vector]){
        self.frame = CGRectMake(0, 0, a1, a2);
    }
    return self;
}

-(void)play
{
    [self play:INTERVAL_TIME];
}

-(void)play:(NSTimeInterval)time{
    [self updateFrame];
    [self stopTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(updateRender)
                                                userInfo:nil repeats:YES];
}

-(BOOL)isPlay{
    return self.timer!=NULL;
}

-(void)stop{
    [self stopTime];
    [self updateFrame];
}

-(void)gotoAndStop:(NSInteger)value
{
    [self stopTime];
    [self updateFrame:value];
}

-(void)gotoAndPlay:(NSInteger)value
{
    [self updateFrame:value];
    [self play];
}

//#private
-(void)stopTime{
    if (self.timer && [self.timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//#private self.currentTime = [[NSDate date] timeIntervalSince1970]*1000;
-(void)updateRender{
    //NSLog(@"update %@",self.frames[self.currentFrame]);
    [self updateFrame:self.currentFrame + 1];
}

//#private
-(void)updateFrame{
    if(self.currentFrame < NONE){
        [self updateFrame:NONE];
    }else{
        [self updateFrame:self.currentFrame];
    }
}

//#private
-(void)updateFrame:(NSInteger)index{
    //if(self.currentFrame == index) return;
    //
    NSArray<NSString*> *vector = self.frames;
    if(self.actionName){
        vector = [self.actionMap objectForKey:self.actionName];
    }
    if(vector == NULL || vector.count == NONE) return;
    if(index >= vector.count){
        index = NONE;
    }
    self.currentFrame = index;
    self.image = [UIImage imageNamed:vector[index]];
    //设置为图片大小
    //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.image.size.width, self.image.size.height);
}


//
-(void)addActionFrames:(NSArray*)vector name:(NSString*)actionName{
    if(!self.actionMap){
        self.actionMap = [[NSMutableDictionary alloc] init];
    }
    [self.actionMap setObject:vector forKey:actionName];
};

-(void)currentAction:(NSString*)actionName{
    self.actionName = actionName;
};

-(BOOL)hasAction:(NSString*)actionName
{
    if(self.actionMap && [self.actionMap objectForKey:actionName]){
        return YES;
    }
    return NO;
};

-(void)removeAction:(NSString*)actionName
{
    if(actionName == self.actionName){
        self.actionName = nil;
    }
    if(self.actionMap){
        [self.actionMap removeObjectForKey:actionName];
    }
};

-(void)gotoAndPlay:(NSString*)actionName beginIndex:(NSInteger)value{
    self.actionName = actionName;
    [self gotoAndPlay:value];
};

-(void)gotoAndStop:(NSString*)actionName currentIndex:(NSInteger)value{
    self.actionName = actionName;
    [self gotoAndStop:value];
};

-(void)playAction:(NSString*)actionName{
    self.actionName = actionName;
    [self play];
};

@end
