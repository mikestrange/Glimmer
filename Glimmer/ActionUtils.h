//
//  ActionUtils.h
//  MyGame
//
//  Created by Mac_Tech on 15/10/29.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActionUtils : NSObject

+(CAAnimation*)addSimpleAction:(NSString*)key fromValue:(id)beginValue toValue:(id)endValue;

@end
