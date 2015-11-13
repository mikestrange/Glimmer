//
//  MapNode.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapController.h"

/*
typedef struct _MapPoint{
    NSInteger x;
    NSInteger y;
}MapPoint;
*/

@interface MapNode : NSObject{
    UIView* _view;
}

@property(assign,nonatomic)NSInteger x;
@property(assign,nonatomic)NSInteger y;
@property(assign,nonatomic)BOOL isOpen;
@property(copy,nonatomic)NSString* name;
//初始化设置路径
@property(copy,nonatomic)NSString* path;
//初始化
-(instancetype)initWithCross:(NSInteger)mx vertical:(NSInteger)my;
//关闭显示
-(void)close;
//节点视图
-(UIView*)image:(UIView*)parent;

@end
