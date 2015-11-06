//
//  IBindVisitor.h
//  Glimmer
//
//  Created by Mac_Tech on 15/11/6.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICommandHandler.h"

@protocol IBindVisitor <ICommandHandler>

-(NSArray*)getNoticeArray;
-(void)launch;
-(void)free;

@end
