//
//  MapInfo.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "MapInfo.h"
#import "XMLNode.h"

@implementation MapInfo

@synthesize nodeHeight;
@synthesize nodeWidth;
@synthesize crossNum;
@synthesize verticalNum;
@synthesize totalHeight;
@synthesize totalWidth;
@synthesize rootFile;

-(instancetype)initWithPath:(NSString*)path
{
    if(self = [super init])
    {
        self.rootFile = path;
        NSString* file = [NSString stringWithFormat:@"%@/config.xml",path];
        [self reading:[XMLNode make:file]];
    }
    return self;
}

//解析
-(void)reading:(XMLNode*)node
{
    XMLNode* next = [node getChildByName:@"map"];
    crossNum = [[next getDictValue:@"x"] intValue];
    verticalNum = [[next getDictValue:@"y"] intValue];
    nodeWidth = [[next getDictValue:@"w"] intValue];
    nodeHeight = [[next getDictValue:@"h"] intValue];
    totalWidth = crossNum*nodeWidth;
    totalHeight = verticalNum*nodeHeight;
}

//
-(NSString*)getNodePath:(NSString*)type x:(NSInteger)x y:(NSInteger)y
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
    NSString* file = [NSString stringWithFormat:@"%@/map_%@x%@.%@", self.rootFile, fy, fx, type];
    //NSLog(@"地图节点路径：x = %li ,y = % li ,url = %@", x, y, file);
    return file;
}

-(CGPoint)getNodePoint:(NSInteger)x y:(NSInteger)y
{
    return CGPointMake(x*self.nodeWidth, y*self.nodeHeight);
}


@end
