//
//  IObject.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/5.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IObject <NSObject>

-(void)applyHandler:(NSString*)notice target:(id)info;
-(void)currentDelegate:(id)delegate;
-(id)currentDelegate;

@end
