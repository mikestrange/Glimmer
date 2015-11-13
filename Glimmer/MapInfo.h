//
//  MapInfo.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MapInfo : NSObject

//总宽
@property(nonatomic,assign)NSInteger totalWidth;
//总高
@property(nonatomic,assign)NSInteger totalHeight;
//竖数目
@property(nonatomic,assign)NSInteger verticalNum;
//横数目
@property(nonatomic,assign)NSInteger crossNum;
//块宽
@property(nonatomic,assign)NSInteger nodeWidth;
//块高
@property(nonatomic,assign)NSInteger nodeHeight;
//地图文件夹
@property(nonatomic,copy)NSString* rootFile;

//初始化地图数据(XML路径)
-(instancetype)initWithPath:(NSString*)path;
//获取节点地图的路径
-(NSString*)getNodePath:(NSString*)type x:(NSInteger)x y:(NSInteger)y;
//获取节点的位置（全局位置）
-(CGPoint)getNodePoint:(NSInteger)x y:(NSInteger)y;

//end
@end
