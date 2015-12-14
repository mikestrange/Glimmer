//
//  QuickHandler.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "QuickHandler.h"

@implementation QuickHandler



+(UITapGestureRecognizer*)addTouchHandler:(UIView*)target delegate:(id)delegate selector:(SEL)selector
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:delegate action:selector];
    [target addGestureRecognizer:singleTap];
    target.userInteractionEnabled = YES;
    return singleTap;
}

@end
