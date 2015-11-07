//
//  NetSocket.m
//  MyGame
//
//  Created by MikeRiy on 15/10/26.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "NetSocket.h"
#import <CocoaAsyncSocket/CocoaAsyncSocket.h>

static NetSocket* _instance = NULL;
static NSTimeInterval _TIME_ = 10*1000;     //超时时间:10秒
static long SOCKET_OPPTER_TAG = -1;        //一个标记

enum{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};

@implementation NetSocket
//
@synthesize socket = _socket;

//static
+(NetSocket*)getInstance
{
    if(_instance == NULL)
    {
        _instance = [[NetSocket alloc] init];
    }
    return _instance;
}

//连接
-(void)connect:(NSString*)host port:(UInt16)port
{
    if(!self.socket){
        self.socket = [[AsyncSocket alloc] initWithDelegate:self userData:SocketOfflineByServer];
    }
    if(![self isConnected])
    {
        self.socket.userData = SocketOfflineByServer;
        [self.socket connectToHost:host onPort:port error:nil];
        [self.socket readDataWithTimeout:_TIME_ tag:SOCKET_OPPTER_TAG];
    }
}

-(BOOL)isConnected
{
    if(self.socket && [self.socket isConnected]) return YES;
    return NO;
}

// 切断socket
-(void)close
{
    if([self isConnected])
    {
        self.socket.userData = SocketOfflineByUser;// 声明是由用户主动切断
        [self.socket disconnect];
    }
}

-(void)flush:(char*)bytes length:(NSUInteger)len
{
    if([self isConnected])
    {
        NSData* data = [NSData dataWithBytes:bytes length:len];
        [self.socket writeData:data withTimeout:_TIME_ tag:SOCKET_OPPTER_TAG];
    }
}

//delegate------

#pragma mark  - 重连断开socket连接
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"sorry the connect is failure %ld",sock.userData);
    if (sock.userData == SocketOfflineByServer) {
        // 服务器掉线，重连
        NSLog(@"服务器掉线，重连");
    }else if (sock.userData == SocketOfflineByUser) {
        // 如果由用户断开，不进行重连
        NSLog(@"如果由用户断开，不进行重连");
    }
}

#pragma mark  - 连接成功回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"did connect to host");
    //test
    [NSTimer scheduledTimerWithTimeInterval:1
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
    [self.socket readDataWithTimeout:_TIME_ tag:SOCKET_OPPTER_TAG];
    //-----reading---------
    NSLog(@"did read data");
    int length = (int)data.length;
    char *byte = (char*)data.bytes;
    int position = 4+4+2+1+2;
    char *t = malloc(length-position);
    int index = 0;
    for(int i = position;i<length;i++){
        t[index++] = byte[i];
    }
    NSLog(@"%s",t);
}

@end
