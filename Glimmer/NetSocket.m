//
//  NetSocket.m
//  MyGame
//
//  Created by MikeRiy on 15/10/26.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "NetSocket.h"

static NetSocket* _instance = NULL;

@implementation NetSocket
//static
+(NetSocket*)getInstance
{
    if(_instance == NULL)
    {
        _instance = [[NetSocket alloc] init];
    }
    return _instance;
}

#pragma mark  - 连接成功回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [super onSocket:sock didConnectToHost:host port:port];
    //test
    [NSTimer scheduledTimerWithTimeInterval:.01
                                     target:self
                                   selector:@selector(handleTimer)
                                   userInfo:nil
                                    repeats:YES];
}

// 每隔1秒会触发这个方法
- (void)handleTimer
{
    char* t = malloc(6);
    t[0]=0;
    t[1]=0;
    t[2]=0;
    t[3]=2;
    t[4]=123;
    t[5]=124;
    [self flush:t length:6];
    free(t);
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [super onSocket:sock didReadData:data withTag:tag];
    //-----reading---------
    NSLog(@"did read data");
    //
    ByteArray *byte = [[ByteArray alloc] init];
    [byte updateBytes:(BYTE)data.bytes length:data.length];
    NSLog(@"%li",[byte readInt]);
    NSLog(@"%li",[byte readInt]);
    NSLog(@"%li",[byte readShort]);
    [byte readBoolean];
    NSLog(@"%@",[byte readString:@""]);
    //NSLog(@"%s",t);
}

@end
