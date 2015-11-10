//
//  ByteArray.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/8.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef char* BYTE;
typedef long long NSLong;
typedef unsigned long long NSULong;

@interface ByteArray : NSObject

@property(assign,nonatomic)NSInteger position;
@property(assign,readonly,nonatomic)NSInteger length;
@property(assign,readonly,nonatomic)BYTE bytes;

//清理
-(void)clear;

//字节是否为空
-(BOOL)isEmpty;

//移动到开始位置
-(void)moveToBegin;

//剩余字节
-(NSInteger)getScalableTotals;

#pragma setBytes
-(void)updateBytes:(BYTE)bytes length:(NSInteger)len;

#pragma reading
-(BOOL)readBoolean;
-(NSInteger)readByte;
-(NSInteger)readUByte;
-(NSInteger)readShort;
-(NSInteger)readUShort;
-(NSInteger)readInt;
-(NSUInteger)readUInt;
-(NSLong)readLong;
-(NSULong)readULong;
-(NSString*)readString:(NSString*)type;
//读取一个长度，写入到对象中
-(void)readBytes:(ByteArray*)target length:(NSInteger)offLen;

#pragma writting 写入的时候指针不会发生改变
-(void)writeByte:(NSInteger)value;
-(void)writeShort:(NSInteger)value;
-(void)writeInt:(NSInteger)value;
-(void)writeUInt:(NSUInteger)value;
-(void)writeLong:(NSLong)value;
-(void)writeULong:(NSULong)value;
-(void)writeString:(NSString*)value;
//将对象写入自己
-(void)writeBytes:(ByteArray*)target;
//这里从target读取开始到结束的所有字节,写入到自己队列中
-(void)writeBytes:(ByteArray*)target beginfor:(NSInteger)beginIndex;
//这里从target读取开始到一个长度的字节,写入到自己队列中
-(void)writeBytes:(ByteArray*)target beginfor:(NSInteger)beginIndex length:(NSInteger)offLen;

@end
