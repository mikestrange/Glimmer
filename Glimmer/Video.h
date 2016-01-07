//
//  Video.h
//  Glimmer
//
//  Created by MikeRiy on 16/1/7.
//  Copyright © 2016年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


typedef enum{
    AV_ERROR,
    AV_SUCCEED
}AV_STATUS;

@interface Video : NSObject

@property(nonatomic,strong) AVPlayer *player;
@property(nonatomic,strong) AVPlayerLayer *layer;
@property(nonatomic,strong) AVPlayerItem *playerItem;
@property(nonatomic,assign) AV_STATUS status;
@property(nonatomic,strong) UISlider *slider;
@property(nonatomic,assign) CMTime duration;
@property(nonatomic,assign) BOOL isPlay;

-(void)play;
-(void)play:(CMTimeValue)current;
-(void)stop;

-(void)setURL:(NSString*)file;
-(void)addTo:(UIView*)root;
-(void)showSlider:(UISlider*)slider;

@end
