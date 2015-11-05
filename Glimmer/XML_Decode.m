//
//  XMLAnalytical.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "XML_Decode.h"

@implementation XMLAnalysis


-(XMLNode*)parseXml:(NSData*)data
{
    /*
    //读取文件数据
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData* data = [fm contentsAtPath:file];
     */
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    xmlParser.delegate = self;
    BOOL flag = [xmlParser parse];
    if(flag) return root;
    return nil;
}

#pragma - mark 开始解析时
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"---xml---start-------");
}

#pragma - mark 发现节点时
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentNode = [[XMLNode alloc] initWithName:elementName property:attributeDict];
    if(root == nil){
        root = currentNode;
    }else{
        [currentParent addChildNode:currentNode];
    }
    currentParent = currentNode;
}

#pragma - mark 发现节点值时
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [XMLAnalysis trimWhitespaceAndNewline:string];
    if(string.length){
        //NSLog(@"%@",string);
        currentNode.elementValue = string;
    }
}

#pragma - mark 结束节点时
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(currentParent.parent){
        currentParent = currentParent.parent;
    }else{
        currentParent = root;
    }
}

#pragma - mark 结束解析
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    //[root toString];
    NSLog(@"---xml---over-------");
}


#pragma - mark NSString过滤空格和换行
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