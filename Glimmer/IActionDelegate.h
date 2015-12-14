//
//  IAction.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IActionDelegate <NSObject>

@end

/*
 核心动画的几大核心类：
 
 CAAnimation「核心动画基类」：不能直接使用，他遵循并实现了 CAMediaTiming 协议，负责动画运行时间和速度的控制。
 
 CAPropertyAnimation「属性动画基类」：不能直接使用，他通过可动画属性进行动画设置。
 
 CAAnimationGroup「动画组」：他是一种组合模式，可以组合多个动画进行动画行为的统一控制。
 
 CATransition「转场动画」：主要通过滤镜进行动画效果设置。
 
 CABasicAnimation「基础动画」：通过起点和终点状态属性参数进行动画控制。
 
 CAKeyframeAnimation「关键帧动画」：同 CABasicAnimation 一样通过属性参数进行动画控制，但不同的是他可以有多个状态控制，不单单只有起点和终点。
 */