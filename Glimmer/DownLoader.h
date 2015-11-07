//
//  DownLoader.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INetwork.h"

@interface DownLoader : NSObject<INetwork>

/*
 *http请求
 **/
-(void)sendHttps:(NSString*)httpUrl;
/*
 *上传
 **/
-(void)upLoad:(NSString*)httpUrl data:(NSData*)data;
/*
 *下载
 **/
-(void)downLoad:(NSString*)httpUrl;
/*
 *关闭
 **/
-(void)close;

@end
