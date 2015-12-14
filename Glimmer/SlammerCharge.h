//
//  SlammerCharge.h
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EntitySprite.h"


@interface SlammerCharge : NSObject

@property(nonatomic,strong)NSArray<EntitySprite>* vector;

-(void)update;

//-(void)moveOffset:(id)target;

@end
