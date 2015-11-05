//
//  TrimString.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrimString : NSObject

@end


@interface NSString(Trim)

+(NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;

//去掉前后空格
+(NSString *)trimWhitespace:(NSString *)val;

//去掉前后回车符
+(NSString *)trimNewline:(NSString *)val;

//去掉前后空格和回车符
+(NSString *)trimWhitespaceAndNewline:(NSString *)val;

@end
