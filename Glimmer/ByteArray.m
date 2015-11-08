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

@implementation ByteArray

@synthesize position;
@synthesize length = _length;

-(instancetype)initWithByte:(BYTE)byte
{
    if(self = [super init])
    {
        [self setBytes:byte];
    }
    return self;
}

-(void)setBytes:(BYTE)bytes
{
    if(_byte) free(_byte);
    self.position = BEGIN;
    if(bytes){
        _length = sizeof(bytes);
        _byte = malloc(_length);
        for(NSInteger i = BEGIN;i<_length;i++)
        {
            _byte[i] = bytes[i];
        }
    }else{
        _byte = nil;
        _length = NONE;
    }
   
}

-(NSInteger)getScalableTotals
{
    if(_byte) return _length - self.position;
    return NONE;
}

-(void)clear
{
    [self setBytes:nil];
}

-(BYTE)getBytes
{
    return _byte;
}

-(BYTE)getBytes:(NSInteger)beginIndex
{
    NSInteger len = self.length - beginIndex;
    BYTE bit = malloc(len);
    for(NSInteger i = BEGIN; i < len; i++)
    {
        bit[i] = _byte[beginIndex + i];
    }
    return bit;
}

-(BYTE)getBytes:(NSInteger)beginIndex length:(NSInteger)offLen
{
    NSInteger len = MIN(offLen, self.length - beginIndex);
    BYTE bit = malloc(len);
    for(NSInteger i = BEGIN; i < len; i++)
    {
        bit[i] = _byte[beginIndex + i];
    }
    return bit;
}

@end
