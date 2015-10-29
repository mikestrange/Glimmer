//
//  NetSocket.m
//  MyGame
//
//  Created by Mac_Tech on 15/10/27.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import "NetSocket.h"

static NetSocket* _socket = nil;

enum{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};

@implementation NetSocket

@synthesize a_socket = _a_socket;

+(NetSocket*)getSocket
{
    if(nil==_socket){
        _socket = [[NetSocket alloc] init];
       [_socket link];
    }
    return _socket;
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"did connect to host");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"did read data");
    NSInteger len = data.length;
    uint8_t *t = (uint8_t*)data.bytes;
    [self loginResult:t length:len];
}

-(void)loginResult:(uint8_t*)byte length:(NSInteger)len
{
    NSLog(@"begin");
    int all_len = (int)len;
    int point = 4+4+2+1+2;//[len+cmd+type+bool+str_len]
    char* t = malloc(all_len - point);
    int index = 0;
    for(int i = point ; i< all_len; i++){
        t[index++] = byte[i];
        NSLog(@"%i %c", index, byte[i]);
    }
    NSString *str=[NSString stringWithFormat:@"%s", t];
    NSLog(@"l = %@", str);
    NSLog(@"end");
    free(t);
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"sorry the connect is failure %ld",sock.userData);
    if (sock.userData == SocketOfflineByServer) {
        // 服务器掉线，重连
        //[self socketConnectHost];
    }else if (sock.userData == SocketOfflineByUser) {
        // 如果由用户断开，不进行重连
    }
}

-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"willDisconnectWithError");
}

-(void)link
{
    _a_socket=[[AsyncSocket alloc] initWithDelegate:self];
    [_a_socket connectToHost:@"192.168.1.27" onPort:9555 error:nil];
    //
    int len = 4+2;
    char *t = malloc(len);
    t[0] = 0;
    t[1] = 0;
    t[2] = 0;
    t[3] = 2;
    t[4] = 125;
    t[5] = 125;
    NSData * data = [NSData dataWithBytes:t length:len];
    [_a_socket writeData:data withTimeout:1 tag:1];
    [_a_socket readDataWithTimeout:3 tag:1];
    //w[socket writeData:[@"GET / HTTP/1.1nn" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:1];
}

@end
