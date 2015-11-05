//
//  GameScene.m
//  MyGame
//
//  Created by Mac_Tech on 15/10/23.
//  Copyright (c) 2015年 Mac_Tech. All rights reserved.
//

#import "GameScene.h"
#import "NetSocket.h"
#import "ActionUtils.h"
#import "DrawUtils.h"
#import "MoreTableView.h"
#import "Sound.h"
#import "TickUtils.h"
#import <AVFoundation/AVFoundation.h>
#import "XMLNode.h"

@implementation GameScene


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    UIView *black = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.view addSubview:black];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"match_bg.jpg"]];
    image.frame = CGRectMake(0, 0, self.view.frame.size.width*.5f, self.view.frame.size.height);
    [black addSubview:image];
    //
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"match_bg.jpg"]];
    image2.frame = CGRectMake(self.view.frame.size.width*.5f, 0, self.view.frame.size.width*.5f, self.view.frame.size.height);
    image2.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [black addSubview:image2];
    //TableView
    MoreTableView *table = [[MoreTableView alloc] initWithNull];
    [self.view addSubview:table];
    //按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [btn.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    btn.layer.position =CGPointMake(100, 460);
    btn.tag = 1;
    [btn setTitle:@"ZoomIn" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //远程图片
    NSURL *url = [NSURL URLWithString:@"http://avatar.csdn.net/6/8/B/1_chenyong05314.jpg"];
    UIImageView *loader = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
    loader.frame = CGRectMake(0, 0, 100, 100);
    [loader.layer setAnchorPoint:CGPointMake(0, 0)];
    loader.layer.position = CGPointMake(100, 300);
    [self.view addSubview:loader];
    //Events
    //[self getSingleTab:black];
    [self getSingleTab:loader];
    //
    
    //读取文件
    NSString *str2=[[NSString alloc]initWithContentsOfFile:@"/Users/mac_tech/Desktop/develop/texas/frameworks/runtime-src/project/texas_amazon/api_key.txt" encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"什么东东：%@",str2);
    [btn setTitle:str2 forState:UIControlStateNormal];
    //播放声音
    //[[SoundManager getInstance] playSoundOnce:@"/Users/MikeRiy/Documents/quick-3.3/quick/samples/anysdk/res/background.mp3"];
    //
    //连接服务器
    [[NetSocket getInstance] connect:@"127.0.0.1" port:9555];
    //
    [TickManager scheduledOnce:self function:tickHandler(self, calleds) interval:2];
}

-(void)calleds
{
    NSLog(@"click");
    /*[[SoundManager getInstance] playSoundSole:@"/Users/MikeRiy/Documents/quick-3.3/quick/samples/coinflip/res/sfx/LevelWinSound.mp3" forever:NO];
     */
    //
   // NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"config/api_key" ofType:@"txt"];
    XMLNode* data = [XMLNode make:@"/Users/mac_tech/Documents/test.xml"];
    NSLog(@"%@",[data getChildByIndex:0].elementName);
}

-(void)getSingleTab:(UIView*)target
{
    target.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)];
    [target addGestureRecognizer:singleTap1];
}


//执行动画 
-(void)clickCategory:(UIGestureRecognizer *)gestureRecognizer
{
    UIButton *target = (UIButton*)[self.view viewWithTag:1];
    CABasicAnimation *anim = (CABasicAnimation*)[ActionUtils addSimpleAction:@"transform.rotation.z" fromValue:[NSNumber numberWithFloat:0.0] toValue:[NSNumber numberWithFloat:180.0 * M_PI]];
    [anim setDelegate:self];
    [target.layer addAnimation:anim forKey:@"anim"];
}

-(void)clearAction
{
    NSLog(@"upInside...");
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

@end
