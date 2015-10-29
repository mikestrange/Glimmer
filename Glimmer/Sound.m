//
//  Sound.m
//  Glimmer
//
//  Created by MikeRiy on 15/10/29.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "Sound.h"


@implementation Sound

+(AVAudioPlayer*)playSoundEffect:(NSString*)path
{
    //@"/Users/MikeRiy/Desktop/newdali.mp3"
    NSURL *url = [[NSURL alloc] initWithString:path];
    AVAudioPlayer* thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    thePlayer.numberOfLoops = 1;
    [thePlayer prepareToPlay];
    [thePlayer setVolume:1];
    [thePlayer play];
    return thePlayer;
}

@end
