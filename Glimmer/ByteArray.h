//
//  ByteArray.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/8.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef char* BYTE;

@interface ByteArray : NSObject
{
    @private
    BYTE _byte;
}

@property(assign,nonatomic)NSInteger position;
@property(assign,readonly,nonatomic)NSInteger length;

-(instancetype)initWithByte:(BYTE)byte;

-(void)clear;

-(NSInteger)getScalableTotals;

#pragma setBytes
-(void)setBytes:(BYTE)bytes;

#pragma getBytes
-(BYTE)getBytes;
-(BYTE)getBytes:(NSInteger)beginIndex;
-(BYTE)getBytes:(NSInteger)beginIndex length:(NSInteger)offLen;

#pragma reading
-(BOOL)readBoolean;
-(NSInteger)readByte;
-(NSInteger)readUByte;
-(NSInteger)readShort;
-(NSInteger)readUShort;
-(NSInteger)readInt;
-(NSUInteger)readUint;
-(NSString*)readString:(NSInteger)type;
//读取一个长度，写入到对象中
-(void)readBytes:(ByteArray*)target length:(NSInteger)offLen;

#pragma writting
-(void)writeByte:(NSInteger)value;
-(void)writeShort:(NSInteger)value;
-(void)writeInt:(NSInteger)value;
-(void)writeUint:(NSUInteger)value;
-(void)writeString:(NSString*)value;
//这里从target读取开始到结束的所有字节,写入到自己队列中
-(void)writeBytes:(ByteArray*)target beginfor:(NSInteger)beginIndex;
//这里从target读取开始到一个长度的字节,写入到自己队列中
-(void)writeBytes:(ByteArray*)target beginfor:(NSInteger)beginIndex length:(NSInteger)offLen;

@end
