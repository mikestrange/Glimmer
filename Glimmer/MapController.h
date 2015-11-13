//
//  MapController.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapNode.h"
#import "MapInfo.h"
#import "MapCamera.h"

@class MapNode;
@class MapInfo;
@class MapCamera;

@interface MapController : NSObject 

@property(nonatomic,strong)UIView* parent;
@property(nonatomic,strong)MapInfo* info;
@property(nonatomic,retain)MapCamera* camera;
//地图节点
@property(nonatomic,strong)NSMutableDictionary* openList;
//当前渲染节点
@property(nonatomic,strong)NSMutableArray<MapNode *>* nodeList;
//本地的一个坐标(最左边的一个绘制顶点)
@property(nonatomic,assign)float mapX;
@property(nonatomic,assign)float mapY;
//渲染的一个宽高
@property(nonatomic,assign)NSUInteger widthRender;
@property(nonatomic,assign)NSUInteger heightRender;
//
@property(nonatomic,retain)UIView* smallMap;

-(instancetype)initWithInfo:(MapInfo*)data parent:(UIView*)root;
//刷新当前区域
-(void)update;
//移动固定
-(void)moveFixed:(float)x y:(float)y;
//移动便宜
-(void)moveOffset:(float)x y:(float)y;
//设置渲染的宽高(默认为父容器的大小)
-(void)mapRenderSize:(NSUInteger)wide height:(NSUInteger)high;

@end
