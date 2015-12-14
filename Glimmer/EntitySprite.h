//
//  EntitySprite.h
//  Glimmer
//  正方形的实体
//  Created by MikeRiy on 15/11/13.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <UIKit/UIKit.h>

//4个方向
enum Direction
{
    DIRE_LEFT,
    DIRT_RIGHT,
    DIRE_DOWN,
    DIRE_TOP
};

@protocol EntitySprite <NSObject>
@required
-(CGFloat)left;
-(CGFloat)right;
-(CGFloat)top;
-(CGFloat)down;
//
//-(Direction)hitShall;

@end
