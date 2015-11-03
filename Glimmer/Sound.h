//
//  Sound.h
//  Glimmer
//
//  Created by MikeRiy on 15/10/29.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundManager : NSObject<AVAudioPlayerDelegate>
{
    @private
        NSMutableArray* _soundList;
}

+(SoundManager*)getInstance;
/*
 *播放永久的音乐
 **/
-(void)playSoundForever:(NSString*)path;
/*
 *播放一次性的音乐
 **/
-(void)playSoundOnce:(NSString*)path;
/*
 *播放唯一的音乐(bool = 是否永久)
 **/
-(void)playSoundSole:(NSString*)path forever:(BOOL)value;
/*
 *自定义播放的音乐
 **/
-(void)playSound:(NSString*)path times:(NSInteger)value;
/*
 *声音是否在播放
 **/
-(BOOL)hasSound:(NSString*)path;
/*
 *停止一个路径的声音(是否单独停止)
 **/
-(void)stopSoundByPath:(NSString*)path sole:(BOOL)value;

//+(AVAudioPlayer*)createAudioPlayer:(NSString*)url times:(NSInteger)value;
@end

//声音携带的信息
@interface SoundData: NSObject
{
    @private
        NSString* _name;
        AVAudioPlayer* _player;
}

-(instancetype)initWithPath:(NSString*)name sound:(AVAudioPlayer*)song;

-(NSString*)getPlayerName;

-(BOOL)match:(NSString*)name;

-(BOOL)matchAudio:(AVAudioPlayer*)player;

-(void)stop;

@end