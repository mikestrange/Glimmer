//
//  NetSocket.m
//  MyGame
//
//  Created by MikeRiy on 15/10/26.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "ExpandSocket.h"

static NSTimeInterval _TIME_ = 10*1000;     //超时时间:10秒
static long SOCKET_OPPTER_TAG = -1;        //一个标记

enum{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};

@implementation ExpandSocket
//
@synthesize socket;


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
        // 声明是由用户主动切断
        self.socket.userData = SocketOfflineByUser;
        [self.socket disconnect];
    }
}

-(void)flush:(BYTE)bytes length:(NSUInteger)len
{
    if([self isConnected])
    {
        [self.socket writeData:[NSData dataWithBytes:bytes length:len] withTimeout:_TIME_ tag:SOCKET_OPPTER_TAG];
    }
}

//delegate------

#pragma mark  - 重连断开socket连接
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"sorry the connect is failure: %ld",sock.userData);
    if (sock.userData == SocketOfflineByServer) {
        [self onPassiveFault:sock];
    }else if (sock.userData == SocketOfflineByUser) {
        [self onActiveFault:sock];
    }else{
        [self onPassiveFault:sock];
    }
}

-(void)onPassiveFault:(AsyncSocket *)sock
{
    NSLog(@"服务器掉线，重连");
}

-(void)onActiveFault:(AsyncSocket *)sock
{
    NSLog(@"如果由用户断开，不进行重连");
}

#pragma mark  - 连接成功回调
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"连接服务器成功:host = %@, port = %i", host, port);
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [self.socket readDataWithTimeout:_TIME_ tag:SOCKET_OPPTER_TAG];
}

@end
