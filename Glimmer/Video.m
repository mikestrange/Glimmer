//
//  Video.m
//  Glimmer
//
//  Created by MikeRiy on 16/1/7.
//  Copyright © 2016年 MikeRiy. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize player;
@synthesize playerItem;
@synthesize layer;
@synthesize status;
@synthesize isPlay;

-(void)stop{
    isPlay = NO;
    [self.player pause];
}

-(void)play{
    isPlay = YES;
    [self.player play];
}

-(void)play:(CMTimeValue)current
{
    [self.playerItem seekToTime:CMTimeMake(current, self.duration.timescale)];
    [self play];
}

-(void)setURL:(NSString*)file{
    //NSString* file = @"/Users/MikeRiy/Documents/movies/禁止爱情.mp4";
    //URL
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:file];
    //Asset
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    //item
    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //player
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    //[player play];
    //layer
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.layer.videoGravity = AVLayerVideoGravityResizeAspect;
}

-(void)addTo:(UIView*)root{
    [root.layer addSublayer:self.layer];
}

//private
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *)object;
    self.status = AV_ERROR;
    if ([keyPath isEqualToString:@"status"]) {
        if ([item status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            self.status = AV_SUCCEED;
            self.duration = item.duration;
            [self play];
        } else if ([item status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"update");
    }else{
        NSLog(@"update");
    }
}

-(NSString *)convertTime
{
    CGFloat second = (self.duration.value/self.duration.timescale)/60;
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

-(void)showSlider:(UISlider*) slider{
    self.slider = slider;
    [self.slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
}

-(void)updateValue:(id)sender{
    float totals = self.slider.maximumValue - self.slider.minimumValue;
    float current = self.slider.value - self.slider.minimumValue;
    float rate = current/totals;
    [self play:rate*self.duration.value];
}


@end
