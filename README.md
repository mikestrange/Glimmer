# Glimmer
objective-c iOS project


-------------播放声音-------------
#import <AVFoundation/AVFoundation.h>

-(void)playSound:(SystemSoundID)soundId
{
    AudioServicesPlaySystemSound(soundId);
}

- (SystemSoundID)loadSound:(NSString *)soundName
{
    //NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
    NSURL *url = [[NSURL alloc] initWithString:@"/Users/mac_tech/Desktop/game_start.mp3"];
    NSLog(@"sound = %@",url);
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    return soundId;
}

----------------------------------
