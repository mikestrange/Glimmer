//
//  NetSocket.h
//  MyGame
//
//  Created by Mac_Tech on 15/10/27.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/CocoaAsyncSocket.h>


@interface NetSocket : NSObject<AsyncSocketDelegate>

@property(nonatomic,retain) AsyncSocket* a_socket;
+(NetSocket*)getSocket;

@end
