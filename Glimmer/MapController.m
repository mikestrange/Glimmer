//
//  MapController.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "MapController.h"

@implementation MapController

@synthesize info;
@synthesize parent;
@synthesize camera;
@synthesize nodeList;
@synthesize openList;
@synthesize widthRender;
@synthesize heightRender;
@synthesize mapX;
@synthesize mapY;

-(instancetype)initWithInfo:(MapInfo*)data parent:(UIView*)root
{
    if(self = [super init])
    {
        //信息
        self.info = data;
        //容器对象
        self.parent = root;
        //摄像机
        self.camera = [[MapCamera alloc] initWithTarget:self];
        //窗口大小
        [self mapRenderSize:root.bounds.size.width height:root.bounds.size.height];
        //初始化
        [self install:data];
    }
    return self;
}

//private init
-(void)install:(MapInfo*)data
{
    self.nodeList = [[NSMutableArray<MapNode *> alloc] init];
    self.openList = [[NSMutableDictionary alloc] init];
    for(int i=0;i<self.info.crossNum;i++)
    {
        for(int j=0;j < self.info.verticalNum;j++)
        {
            //一横排一排添加
            MapNode *node = [[MapNode alloc] initWithCross:i vertical:j];
            node.path = [self.info getNodePath:@"jpg" x:node.x y:node.y];
            [nodeList addObject:node];
        }
    }
    NSLog(@"init map");
}

//--
-(void)mapRenderSize:(NSUInteger)wide height:(NSUInteger)high
{
    self.widthRender = wide;
    self.heightRender = high;
    NSLog(@"map size :%li,%li,{%li,%li}", wide, high, self.info.nodeWidth, self.info.nodeHeight);
}

-(void)moveFixed:(float)x y:(float)y
{
    const float None = 0;
    //x
    float endx = None;
    float endy = None;
    if(x > self.info.totalWidth - self.widthRender){
        endx = self.info.totalWidth - self.widthRender;
    }else if(x < None){
        endx = None;
    }else{
        endx = x;
    }
    //y
    if(y > self.info.totalHeight - self.heightRender){
        endy = self.info.totalHeight - self.heightRender;
    }else if(y < None){
        endy = None;
    }else{
        endy = y;
    }
    //是否改变了位置
    BOOL boolean = self.mapX==endx && self.mapY==endy;
    //最终位置
    self.mapX = endx;
    self.mapY = endy;
    //渲染
    if(!boolean) [self update];
}

-(void)moveOffset:(float)x y:(float)y
{
    [self moveFixed:(self.mapX + x) y:(self.mapY + y)];
}

-(void)update
{
    //NSLog(@"%li%li",self.info.nodeHeight,self.info.nodeWidth);
    float dx = floor(self.mapX/self.info.nodeWidth);
    float dy = floor(self.mapY/self.info.nodeHeight);
    float xl = ceil((self.widthRender + self.mapX)/self.info.nodeWidth);
    float yl = ceil((self.heightRender + self.mapY)/self.info.nodeHeight);
    const int Begin = 0;
    int startX = MAX(Begin, dx);
    int endX = MIN((int)self.info.crossNum, xl);
    int startY = MAX(Begin,dy);
    int endY = MIN((int)self.info.verticalNum, yl);
    NSLog(@"航线位置：y[%i,%i],x[%i,%i]",startX,endX,startY,endY);
    //位置交换
    for(int i=startX;i<endX;i++)
    {
        for(int j=startY;j<endY;j++)
        {
            MapNode* node = [self mapNode:nil x:j y:i];
            if(node){
                [self openNode:node];
            }
        }
    }
    //渲染视图
    [self updateRender];
}

-(void)updateRender
{
    NSArray *list = [self.openList allValues];
    for(MapNode* node in list){
        if(node.isOpen){
            [self addSubNode:node];
        }else{
            [self removeNode:node];
        }
        node.isOpen = NO;
    }
}

//添加节点渲染
-(void)addSubNode:(MapNode*)node
{
    UIView *image = [node image:self.parent];
    CGPoint point = [self.info getNodePoint:node.x y:node.y];
    point.x += -self.mapX;
    point.y += -self.mapY;
    image.layer.position = point;
}

//取分块
-(MapNode*)mapNode:(id)target x:(int)x y:(int)y
{
    NSInteger index = x + y*self.info.verticalNum;
    return [self.nodeList objectAtIndex:index];
}

//添加到将被显示的列表
-(void)openNode:(MapNode*)node
{
    node.isOpen = YES;
    if(![self hasNode:node])
    {
        [self.openList setObject:node forKey:node.name];
        //
        NSLog(@"add:%@",node.name);
    }
}

//显示列表移除
-(void)removeNode:(MapNode*)node
{
    if([self hasNode:node])
    {
        [node close];
        [self.openList removeObjectForKey:node.name];
        //
        NSLog(@"remove:%@",node.name);
    }
}

//是否存在
-(BOOL)hasNode:(MapNode*)node
{
    return [self.openList objectForKey:node.name] != nil;
}

-(void)dealloc
{
    NSLog(@"释放地图？");
}

@end
