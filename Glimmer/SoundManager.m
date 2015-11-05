//
//  Sound.m
//  Glimmer
//
//  Created by MikeRiy on 15/10/29.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "SoundManager.h"

static const NSInteger FOREVER = -1;
static const NSInteger ONCE = 0;
static const NSInteger DEF_VOLUME = 1;
static SoundManager* _instance = nil;

@implementation SoundManager

-(NSMutableArray*)getVector
{
    if(!_soundList){
        _soundList = [[NSMutableArray alloc] init];
    }
    return _soundList;
}

+(SoundManager*)getInstance
{
    if(nil == _instance){
        _instance = [[SoundManager alloc] init];
    }
    return _instance;
}

-(void)playSoundForever:(NSString*)path
{
    [self playSound:path times:FOREVER];
}

-(void)playSoundOnce:(NSString*)path
{
    [self playSound:path times:ONCE];
}

-(void)playSoundSole:(NSString*)path forever:(BOOL)value
{
    [self stopSoundByPath:path sole:NO];
    if(value){
        [self playSoundForever:path];
    }else{
        [self playSoundOnce:path];
    }
}

-(void)playSound:(NSString*)path times:(NSInteger)value
{
    AVAudioPlayer* player = [SoundManager createAudioPlayer:path times:value];
    player.delegate = self;
    //添加到队列中
    NSLog(@"play sound with path:%@",path);
    [[self getVector] addObject:[[SoundData alloc] initWithPath:path sound:player]];
}

//存在某个声音
-(BOOL)hasSound:(NSString*)path
{
    NSMutableArray* list = [self getVector];
    for(SoundData *data in list)
    {
        if([data match:path]) return YES;
    }
    return NO;
}

//关闭一个名字的声音 sole＝true单独删除 =false集体删除
-(void)stopSoundByPath:(NSString*)path sole:(BOOL)value
{
    NSMutableArray* list = [self getVector];
    for(SoundData *data in list){
        if([data match:path]){
            [data stop];
            [list removeObject:data];
            NSLog(@"remove sound with path:%@",path);
            if(value) break;
        }
    }
}

//代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    SoundData* data = [self stopSoundByAudio:player];
    NSLog(@"complete sound:%@(remove)",[data getPlayerName]);
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    SoundData* data = [self stopSoundByAudio:player];
    NSLog(@"error sound:%@(remove) error:%@", [data getPlayerName], error);
}

-(SoundData*)stopSoundByAudio:(AVAudioPlayer*)player
{
    NSMutableArray* list = [self getVector];
    SoundData* data = nil;
    for(data in list){
        if([data matchAudio:player]){
            [list removeObject:data];
            return data;
        }
    }
    return nil;
}


//----------static--------------建立一个本地声音
+(AVAudioPlayer*)createAudioPlayer:(NSString*)path times:(NSInteger)value
{
    //@"/Users/MikeRiy/Desktop/newdali.mp3"
    NSURL *url = [[NSURL alloc] initWithString:path];
    AVAudioPlayer* thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    thePlayer.numberOfLoops = value;
    [thePlayer prepareToPlay];
    [thePlayer setVolume:DEF_VOLUME];
    [thePlayer play];
    return thePlayer;
}

@end

//-----data--------
@implementation SoundData

@synthesize name = _name;
@synthesize player = _player;

-(instancetype)initWithPath:(NSString*)name sound:(AVAudioPlayer*)player
{
    if(self=[super init])
    {
        _name = name;
        _player = player;
    }
    return self;
}

-(BOOL)match:(NSString*)name
{
    return [self.name isEqualToString:name];
}

-(BOOL)matchAudio:(AVAudioPlayer*)player
{
    return self.player == player;
}

-(void)stop
{
    [self.player stop];
}

-(NSString*)getPlayerName
{
    return self.name;
}


@end