//
//  QuickHandler.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuickHandler : NSObject

//添加鼠标事件
+(UITapGestureRecognizer*)addTouchHandler:(UIView*)target delegate:(id)delegate selector:(SEL)selector;


@end
