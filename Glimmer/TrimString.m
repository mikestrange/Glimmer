//
//  TrimString.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "TrimString.h"

@implementation TrimString

@end


#pragma - mark NSString过滤空格和换行

@implementation NSString(Trim)
//可以作为NSString的扩展,这里私有化
+(NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet
{
    NSString *returnVal = @"";
    if (val) {
        returnVal = [val stringByTrimmingCharactersInSet:characterSet];
    }
    return returnVal;
}

//去掉前后空格
+(NSString *)trimWhitespace:(NSString *)val
{
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
}

//去掉前后回车符
+(NSString *)trimNewline:(NSString *)val
{
    return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]];
}

//去掉前后空格和回车符
+(NSString *)trimWhitespaceAndNewline:(NSString *)val
{
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end