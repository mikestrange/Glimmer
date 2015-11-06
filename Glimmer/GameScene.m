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
#import "SoundManager.h"
#import "TickManager.h"
#import "XMLNode.h"
#import "TrimString.h"
#import "DownLoader.h"
#import "QuickHandler.h"
#import "FacedEmployer.h"
#import "EventDispatcher.h"
#import "ModuleDelivery.h"

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
    //MoreTableView *table = [[MoreTableView alloc] initWithNull];
    //[self.view addSubview:table];
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
    [btn setTitle:@"好好学习" forState:UIControlStateNormal];
    //远程图片
    NSURL *url = [NSURL URLWithString:@"http://avatar.csdn.net/6/8/B/1_chenyong05314.jpg"];
    UIImageView *loader = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
    loader.frame = CGRectMake(0, 0, 100, 100);
    [loader.layer setAnchorPoint:CGPointMake(0, 0)];
    loader.layer.position = CGPointMake(100, 300);
    [self.view addSubview:loader];
    //Events
    //[QuickHandler addTouchHandler:black delegate:self selector:@selector(clickCategory:)];
    [QuickHandler addTouchHandler:loader delegate:self selector:@selector(clickCategory:)];
    //
    //播放声音
    //[[SoundManager getInstance] playSoundOnce:@"/Users/MikeRiy/Documents/quick-3.3/quick/samples/anysdk/res/background.mp3"];
    //
    //连接服务器
    [[NetSocket getInstance] connect:@"127.0.0.1" port:9555];
    //延时调用
    [TickManager scheduledOnce:self function:tickHandler(self, xmlHandler) interval:.5];
    //
}

-(void)xmlHandler
{
    NSLog(@"click");
    //NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"config/api_key" ofType:@"txt"];
    XMLNode* data = [XMLNode make:@"/Users/MikeRiy/Documents/test.txt"];
    //[data toString];
    NSString* str = [data getChildByName:@"map"].elementValue;
    //NSLog(@"%@", str);
    NSArray* arr = [str componentsSeparatedByString:@","];
    NSInteger len = 7;
    NSInteger index = 0;
    for(str in arr)
    {
        str = [NSString trimWhitespaceAndNewline:str];
        NSInteger value = [str integerValue];
        //
        UIImageView* item = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox_selected.png"]];
        NSInteger dx = 50*(index%len);
        NSInteger dy = 50*floor(index/len);
        index++;
        [item.layer setAnchorPoint:CGPointMake(0, 0)];
        item.layer.position = CGPointMake(dx, dy);
        if(value == 1){
            [self.view addSubview:item];
        }
    }
    //NSLog(@"%@", arr);
    //
    //AVPlayerViewController* p;
    //MoviePlayerViewController *w;
    //
    ModuleDelivery* t = [[ModuleDelivery alloc] init];
    [[FacedEmployer getInstance] addModule:t markId:@"t"];
    [t addBindto:self];
    [[FacedEmployer getInstance] sendMessage:@"s"];
    [[FacedEmployer getInstance] sendMessage:@"t"];
}

-(void)noticeHandler:(EventMessage*)event
{
    NSLog(@"dddddd");
}

-(NSArray*)getNoticeArray
{
    return @[@"ts",@"s"];
}

-(void)launch
{
    
}

-(void)free
{
    
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
