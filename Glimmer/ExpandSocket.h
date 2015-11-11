//
//  MyGame
//
//  Created by MikeRiy on 15/10/26.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/CocoaAsyncSocket.h>
#import "ByteArray.h"
#import "INetwork.h"

@interface ExpandSocket : NSObject<AsyncSocketDelegate, INetwork>

@property(nonatomic,retain) AsyncSocket* socket;
//连接服务器
-(void)connect:(NSString*)host port:(UInt16)port;
//是否连接服务器
-(BOOL)isConnected;
//主动和服务器断开
-(void)close;
//向服务器发送数据
-(void)flush:(BYTE)bytes length:(NSUInteger)len;
//连接上服务器
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port;
//收到服务器数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
//主动断开服务器
-(void)onActiveFault:(AsyncSocket *)sock;
//被动断开服务器
-(void)onPassiveFault:(AsyncSocket *)sock;

@end


