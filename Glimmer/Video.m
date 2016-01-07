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

-(void)setPath:(NSString*)file{
    [self setAccept:[NSURL fileURLWithPath:file]];
}

-(void)setURL:(NSString*)file{
    //解决网络播放无声音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    //
    [self setAccept:[NSURL URLWithString:file]];
}

-(void)setAccept:(NSURL*)sourceMovieURL{
    //远程
    //[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]
    //本地
    //[NSURL fileURLWithPath:@"/Users/MikeRiy/Documents/movies/禁止爱情.mp4"]
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
    //--
    id this = self; //1秒2次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 2) queue:dispatch_get_main_queue() usingBlock:^(CMTime value) {
        NSLog(@"xx %f",ceil(value.value/value.timescale));
        [this update:ceil(value.value/value.timescale)];
    }];
}

-(void)update:(float)current{
    
}

-(void)addTo:(UIView*)root
{
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
        //NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        //NSLog(@"Time Interval:%f",timeInterval);
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
