//
//  ActionUtils.m
//  MyGame
//
//  Created by Mac_Tech on 15/10/29.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import "ActionUtils.h"

@implementation ActionUtils

/*
 [UIView beginAnimations:@"abc" context:nil];
 [UIView setAnimationDuration:1.0];
 CGPoint point = target.frame.origin;
 point.x+=100;
 [target setCenter:point];
 [UIView setAnimationDelay:1.0];
 [UIView setAnimationDuration:1.0];
 CGPoint point2 = target.frame.origin;
 point2.y-=50;
 [target setCenter:point2];
 //[UIView setAnimationDidStopSelector:@selector(animationFinished:)];
 [UIView commitAnimations];
 ---
CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
anim.duration =1;
[anim setDelegate:self];
anim.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 360)];
[btn.layer addAnimation:anim forKey:@"anim"];
*/

+(CAAnimation*)addSimpleAction:(NSString*)key fromValue:(id)beginValue toValue:(id)endValue
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    anim.duration = 1;
    anim.repeatCount = 1;
    //这两行决定是否结束后返回
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.fromValue = beginValue;
    anim.toValue = endValue;
    return anim;
}


@end
