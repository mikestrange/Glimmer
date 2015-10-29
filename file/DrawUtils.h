//
//  DrawUtils.h
//  MyGame
//
//  Created by Mac_Tech on 15/10/29.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawUtils : NSObject

+(UIImage *)clipImageInScale:(UIImage *)image toScale:(float)scale;

+(UIImage *)clipImageInRect:(UIImage*)image toRect:(CGRect)rect;
@end
