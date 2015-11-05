//
//  DownLoader.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoader : NSObject

-(void)sendHttps:(NSString*)httpUrl;
-(void)upLoad:(NSString*)httpUrl data:(NSData*)data;
-(void)downLoad:(NSString*)httpUrl;

@end
