//
//  NetSocket.m
//  MyGame
//
//  Created by Mac_Tech on 15/10/26.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import "NetTcp.h"
#import <Foundation/NSObject.h>

static NetTcp* _socket = nil;

@implementation NetTcp

@synthesize inputStream;
@synthesize outputStream;

+(void)getSocket
{
        if(_socket == nil){
            _socket = [[NetTcp alloc] init];
            //[_socket link];
            //[NSThread detachNewThreadSelector:@selector(link) toTarget:_socket withObject:nil];
        }
}

//oc原始连接socket
-(void)link
{
     //NSInputStream* _inputStream;
     //NSOutputStream* _outputStream;
     CFReadStreamRef readStream;
     CFWriteStreamRef writeStream;
     CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.1.27", 9555,
                                        &readStream, &writeStream);
     inputStream = (__bridge NSInputStream *)(readStream);
     outputStream = (__bridge NSOutputStream *)(writeStream);
     [inputStream setDelegate:self];
     [outputStream setDelegate:self];
     [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
     [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
     [inputStream open];
     [outputStream open];
     //
     id timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(flush)
                                   userInfo:nil repeats:YES];
     [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
     NSLog(@"socket end");
}

-(void)flush
{
    NSLog(@"flush");
    [self writeOut:@"1"];
}

//如果断开链接，继续写数据，那么会被堵塞
- (void)writeOut:(NSString *)str
{
    int len = 4+2;
    uint8_t *t = malloc(len);
    t[0] = 0;
    t[1] = 0;
    t[2] = 0;
    t[3] = 2;
    t[4] = 125;
    t[5] = 125;
    [outputStream write:t maxLength:len];
    free(t);
}

 -(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
     //NSLog(@"stream event %i", (int)streamEvent);
     //NSLog(@"%@",theStream);
     switch (streamEvent)
     {
         case NSStreamEventOpenCompleted:
             NSLog(@"打开完成");
             break;
         case NSStreamEventHasSpaceAvailable:
         case NSStreamEventHasBytesAvailable:
             NSLog(@"NSStreamEventHasBytesAvailable");
             if (theStream == inputStream) {
                 uint8_t buffer[1024];
                 NSInteger len;
                 while ([inputStream hasBytesAvailable])
                 {
                     len = [inputStream read:buffer maxLength:sizeof(buffer)];
                     NSLog(@"len = %i",(int)len);
                     if (len > 0) {
                         [self loginResult:buffer length:len];
                     }
                 }
             }
             break;
         case NSStreamEventErrorOccurred:
             NSLog(@"Can not connect to the host!");
             break;
         case NSStreamEventEndEncountered:
             NSLog(@"NSStreamEventEndEncountered!");
             break;
         default:
             NSLog(@"Unknown event %i",(int)streamEvent);
             break;
     }
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

@end
