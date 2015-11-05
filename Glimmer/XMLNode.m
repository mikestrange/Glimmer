//
//  XMLNode.m
//  Glimmer
//
//  Created by Mac_Tech on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "XMLNode.h"
#import "XML_Decode.h"

@implementation XMLNode

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
-(XMLNode*)getChildByIndex:(NSInteger)index
{
    return [self.childrens objectAtIndex:index];
}

//根据名称获取子节点
-(XMLNode*)getChildByName:(NSString*)name
{
    for(XMLNode* data in self.childrens){
        if(data.elementName == name){
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
-(void)addChildNode:(XMLNode*)node
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
    NSLog(@"name = %@ , parent = %@ , value = %@", self.elementName, parentName, self.elementValue);
    for(XMLNode* data in self.childrens){
        [data toString];
    }
}

//直接解析出xml
+(XMLNode*)make:(NSString*)file
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData* data = [fm contentsAtPath:file];
    XMLAnalysis* xml = [[XMLAnalysis alloc] init];
    return [xml parseXml:data];
}

@end
