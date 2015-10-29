//
//  NetTcp.h
//  MyGame
// 不太好的socket
//  Created by Mac_Tech on 15/10/27.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetTcp : NSObject<NSStreamDelegate>

@property(nonatomic,retain) NSInputStream* inputStream;
@property(nonatomic,retain) NSOutputStream* outputStream;

@end
