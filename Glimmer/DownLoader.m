//
//  DownLoader.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//
/* ------test---------
 NSString *httpUrl = @"http://img1.cache.netease.com/catchpic/2/2A/2A8C5233674571F889B7324C336E926F.jpg";
 DownLoader* loader = [[DownLoader alloc] init];
 [loader downLoad:httpUrl];
 */

#import "DownLoader.h"

@implementation DownLoader


//简单的http请求
-(void)sendHttps:(NSString*)httpUrl
{
    NSURL *URL = [NSURL URLWithString:httpUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f]; //maximal timeout is 30s
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error){
                                      [self sendHttpsResultHandler:data response:response error:error];
                                  }];
    [task resume];
}

-(void)sendHttpsResultHandler:(NSData*)data response:(NSURLResponse*)response error:(NSError*)error
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"sendHttpsResultHandler over:%@ %@", str, error);
    //回执：三个打包
}


//上传任务也可以通过一个请求以及一个需要上传的本地文件的URL对应的NSData对象创建
-(void)upLoad:(NSString*)httpUrl data:(NSData*)data
{
    NSURL *URL = [NSURL URLWithString:httpUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:data
                                                      completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                              [self upLoadResultHandler:data response:response error:error];
                                          }];
    
    [uploadTask resume];
}

-(void)upLoadResultHandler:(NSData*)data response:(NSURLResponse*)response error:(NSError*)error
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"upLoadResultHandler over:%@ %@", str, error);
}

//下载任务也需要一个请求，但不同之处在于它们的completionHandler。数据和上传任务在完成时立即返回，但下载任务将数据写入本地的临时文件。completionHandler有责任将文件从它的临时位置移动到一个永久位置，这个永久位置就是块的返回值。
-(void)downLoad:(NSString*)httpUrl
{
    NSURL *URL = [NSURL URLWithString:httpUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                            completionHandler:
                                              ^(NSURL *location, NSURLResponse *response, NSError *error){
                                                  [self downLoadResultHandler:location response:response error:error];
                                              }];
    
    [downloadTask resume];
}

-(void)downLoadResultHandler:(NSURL*)location response:(NSURLResponse*)response error:(NSError*)error
{
    NSLog(@"downLoadResultHandler over");
    //获取默认路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //转化url
    NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
    //下载地址名称
    NSString* fileName = [[response URL] lastPathComponent];
    //新的保存路径
    NSURL *newFileLocation = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
    //拷贝
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFileLocation error:nil];
    NSLog(@"保存至新路径 over:%@", newFileLocation);
    //回执：目标url，保存地址，(原始数据)
}

-(void)close
{
    
}

@end
