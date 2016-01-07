//
//  MapInfo.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "MapInfo.h"
#import "XML_Node.h"

@implementation MapInfo

@synthesize nodeHeight;
@synthesize nodeWidth;
@synthesize crossNum;
@synthesize verticalNum;
@synthesize totalHeight;
@synthesize totalWidth;
@synthesize rootFile;
@synthesize bundle;

-(instancetype)initWithPath:(NSString*)path
{
    if(self = [super init])
    {
        self.rootFile = path;
        NSString* file = [NSString stringWithFormat:@"%@/config.xml",path];
        [self reading:[XML_Node make:file]];
    }
    return self;
}

-(instancetype)initWithBundle:(NSBundle*)_bundle
{
    if(self = [super init])
    {
        self.bundle = _bundle ? _bundle : [NSBundle mainBundle];
        NSString* file = [self.bundle pathForResource:@"config" ofType:@"xml"];
        [self reading:[XML_Node make:file]];
    }
    return self;
}

-(instancetype)initWithBundle
{
    return [self initWithBundle:[NSBundle mainBundle]];
}

//解析
-(void)reading:(XML_Node*)node
{
    XML_Node* next = [node getChildByName:@"map"];
    crossNum = [[next getDictValue:@"x"] intValue];
    verticalNum = [[next getDictValue:@"y"] intValue];
    nodeWidth = [[next getDictValue:@"w"] intValue];
    nodeHeight = [[next getDictValue:@"h"] intValue];
    totalWidth = crossNum*nodeWidth;
    totalHeight = verticalNum*nodeHeight;
}

//
-(NSString*)nodePath:(NSString*)type x:(NSInteger)x y:(NSInteger)y
{
    //map_(y)x(x).type
    NSString* fx = nil;
    NSString* fy = nil;
    const NSInteger NINE = 9;
    if(x > NINE){
        fx = [NSString stringWithFormat:@"%li",x];
    }else{
        fx = [NSString stringWithFormat:@"0%li",x];
    }
    if(y > NINE){
        fy = [NSString stringWithFormat:@"%li",y];
    }else{
        fy = [NSString stringWithFormat:@"0%li",y];
    }
    //
    NSString* file = NULL;
    if(self.rootFile){
        file = [NSString stringWithFormat:@"%@/map_%@x%@.%@", self.rootFile, fy, fx, type];
    }else{
        NSString* path = [NSString stringWithFormat:@"map_%@x%@", fy, fx];
        file = [self.bundle pathForResource:path ofType:type];
    }
    //NSLog(@"地图节点路径：x = %li ,y = % li ,url = %@", x, y, file);
    return file;
}

-(NSString*)smallPath
{
    NSString* file = NULL;
    if(self.rootFile){
        file = [NSString stringWithFormat:@"%@/map.jpg", self.rootFile];
    }else{
        file = [self.bundle pathForResource:@"map" ofType:@"jpg"];
    }
    return file;
}

-(CGPoint)nodePoint:(NSInteger)x y:(NSInteger)y
{
    return CGPointMake(x*self.nodeWidth, y*self.nodeHeight);
}


@end
