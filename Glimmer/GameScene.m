//
//  GameScene.m
//  MyGame
//
//  Created by Mac_Tech on 15/10/23.
//  Copyright (c) 2015年 Mac_Tech. All rights reserved.
//

#import "GameScene.h"

#import <CoreGraphics/CoreGraphics.h>

#define CG_CONTEXT_SHOW_BACKTRACE

@implementation GameScene

@synthesize controller;
@synthesize beginPoint;

-(void)onEnter:(SKView *)view {
    /* Setup your scene here */
    UIView *black = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //black.layer.borderColor = (CGColor){221, 221, 221}
    [view addSubview:black];
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
    btn.layer.position =CGPointMake(100, 460);
    btn.tag = 1;
    [btn setTitle:@"ZoomIn" forState:UIControlStateNormal];
    NSURL *url1 = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
    [btn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url1]] forState:UIControlStateNormal];
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
    //[QuickHandler addTouchHandler:loader delegate:self selector:@selector(clickCategory:)];
    //
    //播放声音
    [[SoundManager getInstance] playSoundOnce:@"/Users/MikeRiy/Documents/quick-3.3/quick/samples/anysdk/res/background.mp3"];
    //
    //连接服务器
    //[[NetSocket getInstance] connect:@"192.168.1.27" port:9555];
    //延时调用
    //[TickManager scheduledOnce:self function:tickHandler(self, xmlHandler) interval:.5];
    //
    [[FacedEmployer getInstance] addCommandVector:[self getEventVector] command:self];
    [[FacedEmployer getInstance] sendMessage:@"s"];
    ///Users/MikeRiy/Home/github/Glimmer/Resources/player
    
}

-(void)onExit{
    [[FacedEmployer getInstance] removeNotices:[self getEventVector] delegate:self];
}

-(NSArray*) getEventVector{
    return @[@"s",@"t"];
}

-(void)eventHandler:(Event*)event
{
    NSLog(@"noticeHandler");
}

-(void)xmlHandler
{
    NSLog(@"click");
    /*
    XMLNode* data = [XMLNode make:@"/Users/MikeRiy/Home/test.txt"];
    [data toString];
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
    */
    
    //
    MapInfo* info = [[MapInfo alloc] initWithPath:@"/Users/MikeRiy/Home/source_code/mapDemo/map/map3"];
    self.controller = [[MapController alloc] initWithInfo:info parent:self.view];
    [self.controller moveFixed:1 y:1];
    //NSLog(@"%@", arr);
    //
    //AVPlayerViewController* p;
    //MoviePlayerViewController *w;
    //
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

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.beginPoint = [touch locationInView:self.view];
}

-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGFloat deltaX = self.beginPoint.x - point.x;
    CGFloat deltaY = self.beginPoint.y - point.y;
    if(self.controller){
        [self.controller moveOffset:deltaX y:deltaY];
    }
    self.beginPoint = point;
}

-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
    
}

//帧事件
-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
}


@end
