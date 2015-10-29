//
//  NetSocket.h
//  MyGame
//
//  Created by MikeRiy on 15/10/26.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/CocoaAsyncSocket.h>

@interface NetSocket : NSObject<AsyncSocketDelegate>

@property(nonatomic,retain) AsyncSocket* socket;

+(NetSocket*)getInstance;

-(void)connect:(NSString*)host port:(UInt16)port;
-(void)close;
-(BOOL)isConnected;

@end


