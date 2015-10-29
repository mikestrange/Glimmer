//
//  Sound.h
//  Glimmer
//
//  Created by MikeRiy on 15/10/29.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Sound : NSObject


+(AVAudioPlayer*)playSoundEffect:(NSString*)url;

@end
