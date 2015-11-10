//
//  ByteArray.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/8.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "ByteArray.h"

static const NSInteger BEGIN = 0;
static const NSInteger NONE = 0;
//
static const NSInteger BIT8 = 8;
static const NSInteger BIT16 = 16;
static const NSInteger BIT24 = 24;
static const NSInteger BIT32 = 32;
static const NSInteger BIT40 = 40;
static const NSInteger BIT48 = 48;
static const NSInteger BIT56 = 56;
//
static const NSInteger LONG_LEN = 8;
static const NSInteger INT_LEN = 4;
static const NSInteger SHORT_LEN = 2;
static const NSInteger BYTE_LEN = 1;

@implementation ByteArray

@synthesize position;
@synthesize length = _length;
@synthesize bytes = _bytes;


-(void)updateBytes:(BYTE)bytes length:(NSInteger)len
{
    if(_bytes) free(_bytes);
    self.position = BEGIN;
    if(bytes){
        _bytes = malloc(len);
        _length = len;
        for(NSInteger i = BEGIN ; i<len; i++){
            _bytes[i] = bytes[i];
        }
    }else{
        _bytes = nil;
        _length = NONE;
    }
}

-(NSInteger)getScalableTotals
{
    if(self.bytes) return self.length - self.position;
    return NONE;
}

-(void)clear
{
    [self updateBytes:nil length:NONE];
}

-(BOOL)isEmpty
{
    return self.length == NONE;
}

-(void)moveToBegin
{
    self.position = BEGIN;
}

#pragma reading
-(BOOL)readBoolean
{
    return [self readUByte] > NONE;
}

-(NSInteger)readByte
{
    u_char value = self.bytes[self.position];
    self.position+=BYTE_LEN;
    return (NSInteger)value;
}

-(NSInteger)readUByte
{
    return [self readByte] & 0xff;
}

-(NSInteger)readShort
{
    u_char v1 = self.bytes[self.position];
    u_char v2 = self.bytes[self.position + 1];
    self.position+=SHORT_LEN;
    return (v1<<BIT8)|v2;
}

-(NSInteger)readUShort
{
    return [self readShort] & 0xffff;
}

-(NSInteger)readInt
{
    u_char v1 = self.bytes[self.position];
    u_char v2 = self.bytes[self.position+1];
    u_char v3 = self.bytes[self.position+2];
    u_char v4 = self.bytes[self.position+3];
    self.position+=INT_LEN;
    return (v1<<BIT24)|(v2<<BIT16)|(v3<<BIT8)|v4;
}

-(NSUInteger)readUInt
{
    return [self readInt] & 0xffffffff;
}

-(NSLong)readLong
{
    u_char v1 = self.bytes[self.position];
    u_char v2 = self.bytes[self.position+1];
    u_char v3 = self.bytes[self.position+2];
    u_char v4 = self.bytes[self.position+3];
    //
    NSInteger p1 = (v1<<BIT24)|(v2<<BIT16)|(v3<<BIT8)|v4;
    //
    u_char v5 = self.bytes[self.position+4];
    u_char v6 = self.bytes[self.position+5];
    u_char v7 = self.bytes[self.position+6];
    u_char v8 = self.bytes[self.position+7];
    NSInteger p2 = ((v5<<BIT24)|(v6<<BIT16)|(v7<<BIT8)|v8)&0xffffffff;
    //
    self.position+=LONG_LEN;
    return (p1<<BIT32)|p2;
}

-(NSULong)readULong
{
    return [self readLong]&0xffffffffffffffffL;
}

-(NSString*)readString:(NSString*)type
{
    NSInteger len = [self readShort];
    BYTE str = malloc(len);
    for(NSInteger i = BEGIN;i<len;i++)
    {
        str[i] = self.bytes[i + self.position];
    }
    self.position+=len;
    NSString* string = [NSString stringWithUTF8String:str];
    free(str);
    return string;
}

//读取一个长度，写入到对象中
-(void)readBytes:(ByteArray*)target length:(NSInteger)offLen
{
    for(NSInteger i = BEGIN; i < offLen; i++)
    {
        [target writeByte:self.bytes[i + self.position]];
    }
    self.position+=offLen;
}

-(void)addToBytes:(BYTE)byte length:(NSInteger)len
{
    NSInteger allLen = self.length + len;
    BYTE c_bytes = malloc(allLen);
    NSInteger i = BEGIN;
    if(self.bytes){
        for(i = BEGIN; i < self.length;i++){
            c_bytes[i] = self.bytes[i];
        }
    }
    NSInteger index = BEGIN;
    for(i = self.length; i < allLen;i++){
        c_bytes[i] = byte[index++];
    }
    //
    [self updateBytes:c_bytes length:allLen];
    //
    free(c_bytes);
}

-(void)writeByte:(NSInteger)value
{
    BYTE byte = malloc(BYTE_LEN);
    byte[0] = value;
    [self addToBytes:byte length:BYTE_LEN];
    free(byte);
}

-(void)writeShort:(NSInteger)value
{
    BYTE bit = malloc(SHORT_LEN);
    //add
    bit[0] = value >> BIT8;
    bit[1] = value & 0xff;
    //
    [self addToBytes:bit length:SHORT_LEN];
    free(bit);
}

-(void)writeInt:(NSInteger)value
{
    BYTE byte = malloc(INT_LEN);
    //add
    byte[0] = (value >> BIT24) & 0xff;
    byte[1] = (value >> BIT16) & 0xff;
    byte[2] = (value >> BIT8) & 0xff;
    byte[3] = value & 0xff;
    [self addToBytes:byte length:INT_LEN];
    free(byte);
}

-(void)writeUInt:(NSUInteger)value
{
    BYTE byte = malloc(INT_LEN);
    //add
    byte[0] = (value >> BIT24) & 0xff;
    byte[1] = (value >> BIT16) & 0xff;
    byte[2] = (value >> BIT8) & 0xff;
    byte[3] = value & 0xff;
    [self addToBytes:byte length:INT_LEN];
    free(byte);
}

-(void)writeLong:(NSLong)value
{
    BYTE byte = malloc(LONG_LEN);
    //add
    byte[0] = (value >> BIT56) & 0xff;
    byte[1] = (value >> BIT48) & 0xff;
    byte[2] = (value >> BIT40) & 0xff;
    byte[3] = (value >> BIT32) & 0xff;
    //
    byte[4] = (value >> BIT24) & 0xff;
    byte[5] = (value >> BIT16) & 0xff;
    byte[6] = (value >> BIT8) & 0xff;
    byte[7] = value & 0xff;
    [self addToBytes:byte length:LONG_LEN];
    free(byte);
}

-(void)writeULong:(NSULong)value
{
    BYTE byte = malloc(LONG_LEN);
    //add
    byte[0] = (value >> BIT56) & 0xff;
    byte[1] = (value >> BIT48) & 0xff;
    byte[2] = (value >> BIT40) & 0xff;
    byte[3] = (value >> BIT32) & 0xff;
    //
    byte[4] = (value >> BIT24) & 0xff;
    byte[5] = (value >> BIT16) & 0xff;
    byte[6] = (value >> BIT8) & 0xff;
    byte[7] = value & 0xff;
    [self addToBytes:byte length:LONG_LEN];
    free(byte);
}

-(void)writeString:(NSString*)value
{
    const BYTE chars = (BYTE)[value UTF8String];
    NSUInteger len = sizeof(chars);
    [self writeShort:len];
    [self addToBytes:chars length:len];
}

-(void)writeBytes:(ByteArray*)target
{
    [self writeBytes:target beginfor:BEGIN length:target.length];
}

//这里从target读取开始到结束的所有字节,写入到自己队列中
-(void)writeBytes:(ByteArray*)target beginfor:(NSInteger)beginIndex
{
    NSInteger len = target.length - beginIndex;
    [self writeBytes:target beginfor:beginIndex length:len];
}

//这里从target读取开始到一个长度的字节,写入到自己队列中
-(void)writeBytes:(ByteArray*)target beginfor:(NSInteger)beginIndex length:(NSInteger)offLen
{
    NSInteger len = MIN(offLen, target.length - beginIndex);
    BYTE byte = malloc(len);
    for(NSInteger i = BEGIN; i < len; i++)
    {
        byte[i] = target.bytes[i];
    }
    [self addToBytes:byte length:len];
    free(byte);
}

-(void)dealloc
{
    [self clear];
}

@end
