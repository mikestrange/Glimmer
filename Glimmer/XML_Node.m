//
//  XMLNode.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "XML_Node.h"

@implementation XML_Node

@synthesize elementValue = _elementValue;
@synthesize elementName = _elementName;
@synthesize parent = _parent;
@synthesize childrens = _childrens;
@synthesize attributeDict = _attributeDict;

-(instancetype)initWithName:(NSString*)name property:(NSDictionary*)property
{
    if(self = [super init]){
        _elementName = name;
        _attributeDict = property;
        _childrens = [[NSMutableArray alloc] init];
    }
    return self;
}

//根据层次获取子节点
-(XML_Node*)getChildByIndex:(NSInteger)index
{
    return [self.childrens objectAtIndex:index];
}

//根据名称获取子节点
-(XML_Node*)getChildByName:(NSString*)name
{
    for(XML_Node* data in self.childrens){
        if([data.elementName isEqualToString:name]){
            return data;
        }
    }
    return nil;
}

//获取属性值
-(NSString*)getDictValue:(NSString*)name
{
    if(self.attributeDict){
        return [self.attributeDict objectForKey:name];
    }
    return nil;
}

//添加自节点
-(void)addChildNode:(XML_Node*)node
{
    node.parent = self;
    [_childrens addObject:node];
}

-(void)toString
{
    NSString* parentName = @"ROOT";
    if(self.parent){
        parentName = self.parent.elementName;
    }
    NSLog(@"name = %@ , parent = %@ , value = %@ dict = %@", self.elementName, parentName, self.elementValue, self.attributeDict);
    for(XML_Node* data in self.childrens){
        [data toString];
    }
}

//直接解析出xml
+(XML_Node*)make:(NSString*)file
{
    //NSFileManager *fm = [NSFileManager defaultManager];
    //NSData* data = [fm contentsAtPath:file];
    NSData* data = [[NSData alloc] initWithContentsOfFile:file];
    XMLAnalysis* xml = [[XMLAnalysis alloc] init];
    return [xml parseXml:data];
}


@end
